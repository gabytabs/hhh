class Api::V1::MangasController < ApplicationController
  before_action :set_manga, only: [:show, :destroy]

  def index

  end

  def show

  end

  def create

  end

  def destroy

  end

  private

  def set_manga
    @manga = Manga.find(params[:id])
  end

  def user_params
    params.require(:manga).permit(:url, :title, :episode)
  end
end
