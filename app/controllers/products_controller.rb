class ProductsController < ApplicationController
  
  def index
    @products = Product.all
    render :index
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product
      render :show
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      @product.shops = Shop.where(id: shop_ids) if shop_ids.present?
      render :show, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find_by(id: params[:id])

    if @product.update(product_params)
      @product.shops = Shop.where(id: shop_ids) if shop_ids.present?
      render :show
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])

    if @product
      @product.destroy
      render json: { message: "Product destroyed successfully" }
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  private

  def product_params
    params.permit(:product_name, :price, :description, :quantity, shop_ids: [])
  end

  def shop_ids
    params[:shop_ids] || []
  end
end
