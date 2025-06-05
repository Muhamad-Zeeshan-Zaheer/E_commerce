class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [ :edit, :update, :destroy ]
  def index
    @products=Product.all
  end
  def new
    @product=Product.new
  end
  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
    if params[:product][:image].blank? && @product.image.attached?
      @product.image.purge
    end
    if @product.update(product_params)
      redirect_to products_path, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, alert: "Product was successfully deleted."
  end
  private

  def set_product
    @product = Product.find(params[:id])
  end
  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
