class ProductsController < ApplicationController
  def index
    @products=Product.all
  end
  def new
    @product=Product.new
  end
  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end
  def destroy

  end
  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
