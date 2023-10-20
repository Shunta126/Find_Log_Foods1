class Public::CommentsController < ApplicationController

 def create
    restaurant = Restaurant.find(params[:restaurant_id])
    comment = Comment.new(comment_params)
    comment.customer_id = current_customer.id
    comment.restaurant_id = restaurant.id
    if comment.customer.email == 'guest@example.com'
      @restaurant = Restaurant.find(params[:restaurant_id])
      @comment = Comment.new
      flash[:notice] = "会員登録後に送信できます！"
      redirect_to restaurant_path(restaurant)
    elsif comment.save
    else
     @error_comment = comment
     @restaurant = Restaurant.find(params[:restaurant_id])
     @comment = Comment.new
     render 'public/restaurants/show'
    end
 end

 def destroy
    Comment.find(params[:id]).destroy
 end

 private

 def comment_params
   params.require(:comment).permit(:comment)
 end

end