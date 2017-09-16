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
    @manga.destroy
  end

  def web_scrap_manga(manga)
    manga_site = Nokogiri::HTML(open(manga.url))

    manga_site.css('div.vung-doc img').each do |img|
      save_manga_img(manga, img)
    end
  end

  def save_manga_img(manga, img)
    manga.manga_contents.new(img_url: img.attr('src'))
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
