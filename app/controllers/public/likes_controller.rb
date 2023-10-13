class Public::LikesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    like = current_customer.likes.new(restaurant_id: @restaurant.id)
    like.save
  end

  def  destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    like = current_customer.likes.find_by(restaurant_id: @restaurant.id)
    like.destroy
  end

  def index
    likes = Like.where(customer_id: current_customer.id).pluck(:restaurant_id)
    @like_restaurants = Restaurant.find(likes)
  end

end
