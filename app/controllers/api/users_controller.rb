class Api::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :get_user_role]

  def show
    render json: User.all
  end

  def get_user_role
    render json: {email: @user.email, role: @user.role}
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
        "success" => "User created successfully",
      }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find_by(email: user_params[:email])
    render_not_found if @user.nil?
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def render_not_found
    render json: { error: 'User not found' }, status: :not_found
  end
end
