class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "customer"
      @customers = Customer.looks(params[:search], params[:word])

    elsif @range == "店舗名"
      @restaurants = Restaurant.looks(params[:search], params[:word], params[:range])

    elsif @range == "所在地"
      @restaurants = Restaurant.looks(params[:search], params[:word], params[:range])
    end
  end

end
