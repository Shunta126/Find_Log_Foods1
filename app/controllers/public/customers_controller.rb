class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customers = Customer.all.order(created_at: :desc).page(params[:page]).per(28)
  end

  def show
    @customer = Customer.find(params[:id])
    @restaurants = @customer.restaurants.order(created_at: :desc).page(params[:page]).per(24)
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @current_entry = Entry.where(customer_id: current_customer.id)
    @anothe_entry = Entry.where(customer_id: @customer.id)
     unless @customer.id == current_customer.id
      @current_entry.each do |current|
        @anothe_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
     end
  end

  def edit
     @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.email == 'guest@example.com'
      flash[:notice] = "会員登録後に変更できます！"
      @restaurants = @customer.restaurants
      render :show
    elsif
      @customer.id == current_customer.id
      @customer.update(customer_params)
      flash[:notice] = "変更が完了しました！"
      redirect_to customer_path(@customer)
    else
      flash[:notice] = "マイページのみ変更可能です！"
      render :edit
    end
  end

  def confirm
    @customer = current_customer
  end

  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to root_path
  end

  def follows
    customer = Customer.find(params[:id])
    @customers = customer.following_customers
  end

  def followers
    customer = Customer.find(params[:id])
    @customers = customer.follower_customers
  end

 private

   def customer_params
     params.require(:customer).permit(:name, :body, :email, :age, :image)
   end

end