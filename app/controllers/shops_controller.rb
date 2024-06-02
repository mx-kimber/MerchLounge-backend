class ShopsController < ApplicationController
  
  def index
    @shops = Shop.all
    render :index
  end

  def show
    @shop = Shop.find_by(id: params[:id])
    if @shop
      render :show
    else
      render json: { error: "Shop not found" }, status: :not_found
    end
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      render :show, status: :created
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @shop = Shop.find_by(id: params[:id])

    if @shop.update(shop_params)
      render :show
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @shop = Shop.find_by(id: params[:id])

    if @shop
      @shop.destroy
      render json: { message: "Shop destroyed successfully" }
    else
      render json: { error: "Shop not found" }, status: :not_found
    end
  end

  private

  def shop_params
    params.permit(:user_id, :shop_name, :description, :image)
  end
end
