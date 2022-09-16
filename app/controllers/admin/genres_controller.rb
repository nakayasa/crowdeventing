class Admin::GenresController < ApplicationController

  #before_action :authenticate_admin!

  def index
    @genres =Genre.all
    @genre =Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genres =Genre.all
    if @genre.save
     flash[:notice] = "ジャンルが追加されました。"
     redirect_to admin_genres_path
    else
     render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
     flash[:notice] = "ジャンルが編集されました。"
     redirect_to admin_genres_path
    else
     render :edit
    end
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

private
  def genre_params
    params.require(:genre).permit(:name, :genre_image)
  end

end