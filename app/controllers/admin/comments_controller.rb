class Admin::CommentsController < ApplicationController
 before_action :authenticate_admin!

 def destroy
  Comment.find(params[:id]).destroy
  redirect_to admin_restaurant_path(params[:restaurant_id])
 end

end
