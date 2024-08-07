class ProductsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authorize_shop_owner, only: [:update, :destroy]
  before_action :current_user

  def index
    if params[:user_id]
      @products = Product.where(user_id: params[:user_id]).includes(:product_images, :shops)
    elsif params[:shop_id]
      @products = Product.joins(:products_shops).where(products_shops: { shop_id: params[:shop_id] }).includes(:product_images, :shops)
    else
      @products = Product.joins(:products_shops).distinct.includes(:product_images, :shops)
    end

    render json: @products.as_json(include: {
      shops: { only: [:id, :shop_name, :description] },
      product_images: { only: [:id, :cloudinary_photo, :created_at, :updated_at] }
    })
  end

  def show
    if @product
      render json: @product.as_json(only: [:id, :product_name, :description, :price, :quantity, :user_id], 
        methods: [:created_at, :updated_at],
        include: {
          shops: { only: [:id, :shop_name, :description] },
          product_images: { only: [:id, :cloudinary_photo, :created_at, :updated_at] }
        })
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
    unless @product
      Rails.logger.error "Product with id #{params[:id]} not found"
      render json: { error: "Product not found" }, status: :not_found
    end
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
