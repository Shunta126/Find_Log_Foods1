class Public::RestaurantsController < ApplicationController

  def index
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

private
   def restaurant_params
     params.require(:restaurant).permit(:restaurant_name, :genre_id, :food_name, :price, :body, :place, :image)
   end
