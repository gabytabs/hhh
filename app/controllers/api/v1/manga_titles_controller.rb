class Api::V1::MangaTitlesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def index
    @titles = MangaTitle.all
    render json: @titles, each_serializer: MangaTitleSerializer
  end

  def show
    @title = MangaTitle.find(params[:id])
    render json: @title, serializer: MangaTitleSerializer
  end

  def create
    @title = current_user.manga_titles.new(manga_title_params)

    if @title.save
      render json: @title, status: :created
    else
      head (:unprocessable_entity)
    end

  end

  def destroy
    @title = MangaTitle.find(params[:id])
    if @title.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end

  end

  private

  def manga_title_params
    params.require(:manga_title).permit(:title, :level)
  end

end
