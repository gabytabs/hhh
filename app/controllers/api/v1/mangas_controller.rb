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
    pages = get_pages_links(page, agent)

    #Open links inside links
    links_set = get_img_links(pages, agent)

    #Webscrapper
    links_set.each do |links|
      i = 0
      while i < links.length
        link = links[i].click
        epi = Nokogiri::HTML(link.body)
        img = epi.css('img#img').attr('src')
        page_number = links[i].text

        save_manga_img(manga, img, page_number)

        i += 1
      end
    end
  end

  def get_pages_links(page, agent)
    i = 1
    pages = []
    while i <= page_num(page).last
      stringify = i.to_s
      agent.page.links.find do |link|
        if link.text == stringify && stringify.length == 1
          pages.push(link)
        end
      end
      i += 1
    end
    return pages
  end

  def get_img_links(pages, agent)
    i = 0
    links_of_page = []
    while i < pages.length
      page = pages[i].click
      links = links_for_scrapping(page, agent, i)
      links_of_page.push(links)
      i += 1
    end
    return links_of_page
  end

  def links_for_scrapping(page, agent, page_i)
    links = []

    if page_i == 0
      i = 1
      while i <= page_num(page).last
        stringify = i.to_s
        num = "0"+stringify

        agent.page.links.find { |link|
          if link.text == num || link.text == "0"+num
            links.push(link)
          elsif link.text == stringify && stringify.length == 2
            links.push(link)
          end
        }
        i += 1
      end
    else
      page_number = page_i * 40
      i = 1

      while i <= page_num(page).last
        increment_page = page_number + i
        stringify = increment_page.to_s
        num = "0"+stringify

        agent.page.links.find { |link|
          if link.text == num
            links.push(link)
          elsif link.text == stringify && stringify.length == 3
            links.push(link)
          end
        }
        i += 1
      end
    end
    return links
  end

  def page_num(page)
    get_page_number = Nokogiri::HTML(page.body)
    pages = []

    get_page_number.css('div.gdtm').each_with_index do |img, i|
      pages.push(i+1)
    end

    return pages
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
