class CartsController < ApplicationController
  def show
    user = User.find(session[:user_id]) if session[:user_id]
    if user
      @user_name = "#{user.first_name} #{user.last_name}"
      @user_email = user.email
    else
      @user_name = 'Khurram Virani'
      @user_email = 'kvirani@gmail.com'
    end
  end

  def add_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, +1)

    redirect_to :back
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)

    redirect_to :back
  end

  private

  def modify_cart_delta(product_id, delta)
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    update_cart cart
  end
end
