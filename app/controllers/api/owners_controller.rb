class Api::OwnersController < ApplicationController
    before_action :set_owner, only: [:update, :destroy, :is_any_missing_details, :owner_details, :show]
  
    def show
      render json: Owner.all
    end
  
    def create
      @owner = Owner.new(owner_params)
  
      if @owner.save
        render json: { success: 'Owner created successfully' }, status: :created
      else
        render json: { errors: @owner.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @owner.update(owner_params)
        render json: @owner
      else
        render json: { errors: @owner.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @owner.destroy
      head :no_content
    end
  
    def is_any_missing_details
      if @owner.email.blank? || @owner.phone.blank?
        render json: { missing: true }
      else
        render json: { missing: false }
      end
    end
  
    def owner_details
      render json: @owner
    end
  
    private
  
    def set_owner
      @owner = Owner.find_by(email: owner_params[:email])
      render_not_found if @owner.nil?
    end
  
    def owner_params
      params.require(:owner).permit(:email, :phone)
    end
  
    def render_not_found
      render json: { error: 'Owner not found' }, status: :not_found
    end
  end
  