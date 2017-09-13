class Api::V1::MangasController < ApplicationController
  before_action :authenticate_user
  before_action :set_manga, only: [:show, :destroy]

  def index
    @mangas = Manga.all
    render json: @mangas, each_serializer: MangaSerializer
  end

  def show
    render json: @manga, serializer: MangaSerializer
  end

  def create
    @manga = current_user.mangas.build(manga_params)
    if @manga.save
      render json: @manga, status: :created
    end
  end

  def destroy
    @manga.destroy
  end

  private

  def set_manga
    @manga = Manga.find(params[:id])
  end

  def manga_params
    params.require(:manga).permit(:url, :title, :episode)
  end

end
