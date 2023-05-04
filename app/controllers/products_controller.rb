require 'byebug'
class ProductsController < ApplicationController
  def index
    @products = Product.published()
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)
    category_ids = params[:product][:category_id]
    if @product.save
      category_ids.each do |category_id|
        @product.category_products.create(category_id: category_id)
      end
      redirect_to controller: :products, action: :index
    else
      # binding.pry
      render 'new'
    end
  end

  
  private
  
  def product_params
    params.require(:product).permit(:title, :description, :price, :published)
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
