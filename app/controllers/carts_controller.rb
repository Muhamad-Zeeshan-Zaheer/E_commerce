class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @cart = current_user.cart
  end

  def add_to_cart
    cart = current_cart
    item = Item.find(params[:item_id])
    cart_item = cart.cart_items.find_or_initialize_by(item: item)

    if cart_item.new_record?
      cart_item.quantity = 1
    else
      cart_item.quantity += 1
    end

    if cart_item.save
      redirect_to cart_path(cart), notice: 'Item added to cart.'
    else
      redirect_to items_path, alert: 'Error adding item to cart.'
    end
  end

  def remove_from_cart
    cart_item = current_cart.cart_items.find_by(id: params[:id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path(current_cart), notice: 'Item removed from cart.'
    else
      redirect_to cart_path(current_cart), alert: 'Error removing item.'
    end
  end
  

  def increase_quantity
    cart_item = current_cart.cart_items.find_by(id: params[:id])
    if cart_item
      cart_item.increment!(:quantity)
      redirect_to cart_path(cart_item.cart), notice: 'Quantity increased.'
    else
      redirect_to cart_path(cart_item.cart), alert: 'Error updating quantity.'
    end
  end

  def decrease_quantity
    cart_item = current_cart.cart_items.find_by(id: params[:id])
    if cart_item
      if cart_item.quantity > 1
        cart_item.decrement!(:quantity)
        redirect_to cart_path(cart_item.cart), notice: 'Quantity decreased.'
      else
        cart_item.destroy
        redirect_to cart_path(cart_item.cart), notice: 'Item removed from cart.'
      end
    else
      redirect_to cart_path(cart_item.cart), alert: 'Error updating quantity.'
    end
  end

  private

  def current_cart
    current_user.cart || Cart.create(user: current_user)
  end
end
