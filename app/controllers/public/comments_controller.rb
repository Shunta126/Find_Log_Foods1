class Public::CommentsController < ApplicationController

 def create
    restaurant = Restaurant.find(params[:restaurant_id])
    comment = Comment.new(comment_params)
    comment.customer_id = current_customer.id
    comment.restaurant_id = restaurant.id
    comment.save
    redirect_to restaurant_path(restaurant)
 end

 def destroy
    Comment.find(params[:id]).destroy
    redirect_to restaurant_path(params[:restaurant_id])
 end

 private

 def comment_params
   params.require(:comment).permit(:comment)
 end

end
