class Public::RestaurantsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @restaurants = @genre.restaurants.all.order(created_at: :desc).page(params[:page]).per(24)
    else
      @restaurants = Restaurant.all.order(created_at: :desc).page(params[:page]).per(24)
    end

  end

  def new
    @restaurant = Restaurant.new
    @genres = Genre.all
    @customers = Customer.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.customer_id = current_customer.id
    if @restaurant.customer.email == 'guest@example.com'
      @genres = Genre.all
      flash[:notice] = "会員登録後に投稿できます！"
      render :new
    elsif @restaurant.save
      flash[:notice] = "投稿しました！"
      redirect_to restaurants_path
    else
      @genres = Genre.all
      render :new
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
