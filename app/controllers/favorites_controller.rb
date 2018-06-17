class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}さんのつぶやきをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(params[:picture_id]).destroy
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}さんのつぶやきをお気に入り解除しました"
  end
end