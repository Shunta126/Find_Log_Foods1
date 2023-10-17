class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

end