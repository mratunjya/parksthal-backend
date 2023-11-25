class Api::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :get_user_role]

  def show
    render json: User.all
  end

  def get_user_role
    render json: { email: @user.email, role: @user.role }
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { success: 'User created successfully' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      handle_user_role_creation(@user.email, @user.role)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
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

  def handle_user_role_creation(email, role)
    case role
    when 'consumer'
      create_consumer(email) unless consumer_exists?(email)
    when 'attendant'
      create_attendant(email) unless attendant_exists?(email)
    when 'owner'
      create_owner(email) unless owner_exists?(email)
    end
  end

  def consumer_exists?(email)
    Consumer.exists?(email: email)
  end

  def create_consumer(email)
    !Consumer.create(email: email)
  end

  def attendant_exists?(email)
    Attendant.exists?(email: email)
  end

  def create_attendant(email)
    !Attendant.create(email: email)
  end

  def owner_exists?(email)
    Owner.exists?(email: email)
  end

  def create_owner(email)
    !Owner.create(email: email)
  end
end
