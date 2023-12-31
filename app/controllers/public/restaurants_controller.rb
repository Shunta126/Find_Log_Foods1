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

  def timeline
    customer = Customer.find(current_customer.id)
    customers = customer.following_customers
    @restaurants = customers.restaurants.order(create_at: :desc).page(params[:page]).per(24)
  end

  def new
    @restaurant = Restaurant.new
    @genres = Genre.all
    @customers = Customer.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    tags = Vision.get_image_data(restaurant_params[:image]) if restaurant_params[:image].present?
    @restaurant.customer_id = current_customer.id
    if @restaurant.customer.email == 'guest@example.com'
      @genres = Genre.all
      flash[:notice] = "会員登録後に投稿できます！"
      render :new
    elsif @restaurant.save
      if tags.present?
        tags.each do |tag|
          @restaurant.tags.create(name: tag)
        end
      end
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
    if @restaurant.customer.id == current_customer.id
      @restaurant.update(restaurant_params)
      flash[:notice] = "変更しました！"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = "自分の投稿のみ変更可能です！"
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

 private

   def restaurant_params
     params.require(:restaurant).permit(:restaurant_name, :genre_id, :food_name, :price, :body, :place, :image)
   end

end