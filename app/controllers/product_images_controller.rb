class ProductImagesController < ApplicationController
  before_action :set_product_image, only: %i[ show edit update destroy ]

  def index
    folder_name = 'MerchLounge'
    @cloudinary_images = Cloudinary::Api.resources(type: 'upload', max_results: 100, prefix: folder_name)

    respond_to do |format|
      format.json { render json: @cloudinary_images }
    end
  end

  def show
  end

  # def new
  #   @product_image = ProductImage.new
  # end

  def edit
  end

  def create
    @product_image = ProductImage.new(product_image_params)

    respond_to do |format|
      if @product_image.save
        format.html { redirect_to product_image_url(@product_image), notice: "Product image was successfully created." }
        format.json { render :show, status: :created, location: @product_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product_image.update(product_image_params)
        format.html { redirect_to product_image_url(@product_image), notice: "Product image was successfully updated." }
        format.json { render :show, status: :ok, location: @product_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_image.destroy!

    respond_to do |format|
      format.html { redirect_to product_images_url, notice: "Product image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload_image
    file = params[:file]
    folder_name = 'MerchLounge'
    transformation_preset = 'scaleFill'
  
    begin
      search_result = Cloudinary::Api.resource(file.original_filename)
  
      if search_result['public_id']
        render json: { message: 'Image already exists in Cloudinary', public_id: search_result['public_id'] }
        return
      end
  
      cloudinary_response = Cloudinary::Uploader.upload(
        file.path,
        upload_preset: ENV['CLOUDINARY_UPLOAD_PRESET'],
        folder: folder_name,
        public_id: file.original_filename,
        transformation: { transformation: transformation_preset }
      )
  
      render json: cloudinary_response
    rescue Cloudinary::Api::Error => except
      if except.message.include?('Resource not found')
        cloudinary_response = Cloudinary::Uploader.upload(
          file.path,
          upload_preset: ENV['CLOUDINARY_UPLOAD_PRESET'],
          folder: folder_name,
          public_id: file.original_filename,
          transformation: { transformation: transformation_preset }
        )
  
        render json: cloudinary_response
      else
        Rails.logger.error("Error uploading image to Cloudinary: #{except.message}")
        render json: { error: 'Error uploading image to Cloudinary' }, status: :internal_server_error
      end
    end
  end

  private

  def set_product_image
    @product_image = ProductImage.find(params[:id])
  end

  def product_image_params
    params.permit(:file, :cloudinary_photo, :product_id)
  end
end
