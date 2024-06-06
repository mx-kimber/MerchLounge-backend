class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def index
    @users = User.all
    render :index
  end

  def show
    if @user
      render :show
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user
      @user.destroy
      render json: { message: "User destroyed successfully" }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def authorize_user
    unless @user == current_user
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password,
      :password_confirmation,
      :seller
    )
  end
end
