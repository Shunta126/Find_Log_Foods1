class Public::MessagesController < ApplicationController
  before_action :authenticate_customer!, :only => [:create]

  def create
    @message = Message.new(message_params)
    @message.customer_id = current_customer.id
    if @message.save
      redirect_to room_path(@message.room)
    else
      flash[:notice] = "未入力、もしくは200字をオーバーしています。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def message_params
      params.require(:message).permit(:room_id, :body, :message)
    end
end
