class Public::HomesController < ApplicationController

  def top
    @restaurants = Restaurant.order("created_at DESC").limit(3)
  end

  def about
  end

end
