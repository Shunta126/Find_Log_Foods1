class Public::LikesController < ApplicationController

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

end
