class ProductImagesController < ApplicationController
  before_action :set_product_image, only: [:show, :update, :destroy]


  def index
    @product_images = ProductImage.all
    render json: @product_images
  end
  
  def show
    render json: @product_image
  end

  def create
    @product_image = ProductImage.new(product_image_params)

    if @product_image.save
      render json: @product_image, status: :created, location: @product_image
    else
      render json: @product_image.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product_image.update(product_image_params)
      render json: @product_image
    else
      render json: @product_image.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product_image.destroy
  end

  private

  def set_product_image
    @product_image = ProductImage.find(params[:id])
  end

  def product_image_params
    params.permit(:image_url, :product_id)
  end
end
