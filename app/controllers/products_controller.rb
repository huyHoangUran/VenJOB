# require 'byebug'
class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @products = Product.all.page(params[:page]).per(3)
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
      flash[:notice] = 'Product created successfully'
      category_ids.each do |category_id|
        @product.category_products.create(category_id: category_id)
      end
      redirect_to controller: :products, action: :index
    else
      # binding.pry
      flash.now[:notice] = 'Product error in your form'
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @selected_categories = @product.categories
  end

  def update
    @product = Product.find(params[:id])
    category_ids = params[:product][:category_id]

    if @product.update(product_params)
      flash[:notice] = 'Product updated successfully'
      @product.category_products.destroy_all
      category_ids&.each do |category_id|
        @product.category_products.create(category_id: category_id)
      end
      redirect_to controller: :products, action: :index
    else
      flash.now[:notice] = 'Product error in your form'
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :published, :image)
  end
end
