class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "customer"
      @customers = Customer.looks(params[:search], params[:word]).order(created_at: :desc)

    elsif @range == "店舗名"
      @restaurants = Restaurant.looks(params[:search], params[:word], params[:range]).order(created_at: :desc)

    elsif @range == "所在地"
      @restaurants = Restaurant.looks(params[:search], params[:word], params[:range]).order(created_at: :desc)
    end
  end

end
