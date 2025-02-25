class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  def index
    @items=Item.all
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to items_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item was successfully updated.'
      redirect_to items_path
    else
      render :edit ,status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  private

  def set_item
    @item=Item.find(params[:id])
  end
  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id)
  end
end
