class ProductsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authorize_shop_owner, only: [:update, :destroy]
  before_action :current_user

 # app/controllers/products_controller.rb
# def index
#   @products = Product.includes(:shops).all
#   render json: @products.to_json(include: :shops)
# end

def index
  if params[:shop_id]
    @products = Product.joins(:products_shops).where(products_shops: { shop_id: params[:shop_id] })
  else
    @products = Product.all
  end
  render json: @products
end

  def show
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
    if @product.update(product_params)
      @product.shops = Shop.where(id: shop_ids) if shop_ids.present?
      render :show
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product
      @product.destroy
      render json: { message: "Product destroyed successfully" }
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def authorize_shop_owner
    unless @product && @product.user == current_user
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end

  def product_params
    params.permit(:product_name, :price, :description, :quantity, shop_ids: [])
  end

  def shop_ids
    params[:shop_ids] || []
  end
end
