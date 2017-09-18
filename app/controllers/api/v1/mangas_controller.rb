require 'mechanize'

class Api::V1::MangasController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_manga, only: [:show, :destroy]

  def index
    title_manga = MangaTitle.find(params[:manga_title_id])
    mangas = title_manga.mangas.all
    render json: mangas, each_serializer: MangaSerializer
  end

  def show
    render json: @manga, serializer: MangaSerializer
  end

  def create
    @title = MangaTitle.find(params[:manga_title_id])
    @manga = @title.mangas.build(manga_params)

    if @manga.save
      web_scrap_manga(@manga)
      render json: @manga, status: :created
    else
      head(:unauthorized_entity)
    end
  end

  def destroy
    title_manga = MangaTitle.find(params[:manga_title_id])

    if @manga.destroy
      render json: title_manga.mangas.all, each_serializer: MangaSerializer, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  def web_scrap_manga(manga)
    #Secret Agent Robot
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    #Page wanted
    page = agent.get(params[:url])

    #Array of links of thumbnails for Site
    links = get_links(page, agent)

    #Webscrap imgs wanted
    i = 1
    while i < page_num(page)
      link = links[i].click
      epi = Nokogiri::HTML(link.body)
      img = epi.css('img#img').attr('src')

      save_manga_img(manga, img, i)

      i += 1
    end
  end

  def get_links(page, agent)
    i = 0
    links = []
    while i < page_num(page)
      num = i.to_s
      if num.length == 1
        num_w_zero = "0" + num
        get_page = agent.page.link_with(text: num_w_zero)
        links.push(get_page)
      else
        get_page = agent.page.link_with(text: num)
        links.push(get_page)
      end
      i += 1
    end
    return links
  end

  def page_num(page)
    get_page_number = Nokogiri::HTML(page.body)
    pages = []

    get_page_number.css('div.gdtm').each_with_index do |img, i|
      pages.push(i+1)
    end

    return pages.last
  end

  def save_manga_img(manga, img, page_num)
    manga.manga_contents.new(img_url: img, page_num: page_num)
    manga.save
  end

  private

  def set_manga
    title = MangaTitle.find(params[:manga_title_id])
    @manga = title.mangas.find(params[:id])
  end

  def manga_params
    params.require(:manga).permit(:url, :episode)
  end

end
