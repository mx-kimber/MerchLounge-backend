class UsersController < ApplicationController
  before_action :authenticate_user, only: [:update, :destroy]
  before_action :current_user, only: [:show, :update, :destroy]


  def index
    @users = User.all
    render :index
  end

  def show
    if current_user
      @user = current_user
      render :show
    else
      render json: { error: "Unauthorized access" }, status: :unauthorized
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
    if @user = current_user
    @user.update(user_params)
      render :show
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user = current_user
      @user.destroy
      render json: { message: "User destroyed successfully" }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  # def authorize_user
  #   unless @user == current_user
  #     render json: { error: "You are not authorized to perform this action" }, status: :forbidden
  #   end
  # end

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
