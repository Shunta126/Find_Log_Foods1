class Public::HomesController < ApplicationController

  def top
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @restaurants = Restaurant.includes(:likes).limit(3).sort_by { |restaurant| -restaurant.likes.where(created_at: from...to).count }
  end

  def about
  end

end