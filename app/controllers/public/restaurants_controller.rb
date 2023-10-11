class Public::RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
    @genres = Genre.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.customer_id = current_customer.id
    if @restaurant.save
      flash[:notice] = "投稿しました！"
      redirect_to restaurants_path
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @genres = Genre.all
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

end

private
   def restaurant_params
     params.require(:restaurant).permit(:restaurant_name, :genre_id, :food_name, :price, :body, :place, :image)
   end
