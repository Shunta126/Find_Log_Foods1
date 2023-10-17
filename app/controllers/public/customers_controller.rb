class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @restaurants = @customer.restaurants
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
    elsif @customer.update(customer_params)
      flash[:notice] = "変更が完了しました！"
      redirect_to customer_path(@customer)
    else
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

end

 private
   def customer_params
     params.require(:customer).permit(:name, :body, :email, :age, :image)
   end
