require 'nokogiri'
require 'open-uri'

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
    manga_site = Nokogiri::HTML(open(params[:url])) #refactor to check valid url later

    manga_site.css('div.vung-doc img').each_with_index do |img, i|
      page_num = i + 1
      save_manga_img(manga, img, page_num)
    end
  end

  def save_manga_img(manga, img, page_num)
    manga.manga_contents.new(img_url: img.attr('src'), page_num: page_num)
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
