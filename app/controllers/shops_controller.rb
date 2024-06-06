class ShopsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_shop, only: [:show, :update, :destroy]
  before_action :authorize_shop_owner, only: [:update, :destroy]

  def index
    @shops = Shop.all
    render :index
  end

  def show
    if @shop
      @products = @shop.products
      render :show
    else
      render json: { error: "Shop not found" }, status: :not_found
    end
  end

  def create
    @shop = current_user.shops.build(shop_params)

    if @shop.save
      render :show, status: :created
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @shop.update(shop_params)
      render :show
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @shop
      @shop.destroy
      render json: { message: "Shop destroyed successfully" }
    else
      render json: { error: "Shop not found" }, status: :not_found
    end
  end

  private

  def set_shop
    @shop = Shop.find_by(id: params[:id])
  end

  def authorize_shop_owner
    @shop = current_user.shops.find_by(id: params[:id])
    unless @shop
      render json: { error: "Shop not found or you are not authorized to perform this action" }, status: :forbidden
    end
  end

  def shop_params
    params.permit(:shop_name, :description, :image)
  end
end
