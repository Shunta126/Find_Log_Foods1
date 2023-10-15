class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @restaurants = @genre.restaurants.all
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @genres = Genre.all
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:notice] = "変更しました！"
      redirect_to admin_restaurant_path(@restaurant)
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to admin_restaurants_path
  end

end

private
   def restaurant_params
     params.require(:restaurant).permit(:restaurant_name, :genre_id, :food_name, :price, :body, :place, :image)
   end