class Api::AttendantsController < ApplicationController
    before_action :set_attendant, only: [:update, :destroy, :is_any_missing_details, :attendant_details, :show]

    def show
        render json: Attendant.all
    end

    def create
      @attendant = Attendant.new(attendant_params)
  
      if @attendant.save
        render json: {
          "success" => "Attendant created successfully",
        }, status: :created
      else
        render json: @attendant.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @attendant.update(attendant_params)
        render json: @attendant
      else
        render json: @attendant.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @attendant.destroy
      head :no_content
    end
  
    def is_any_missing_details
      if @attendant.email.blank? || @attendant.phone.blank?
        render json: { missing: true }
      else
        render json: { missing: false }
      end
    end

    def attendant_details
        render json: @attendant
      end
  
    private
  
    def set_attendant
      @attendant = Attendant.find_by(email: attendant_params[:email])
      render_not_found if @attendant.nil?
    end
  
    def attendant_params
      params.require(:attendant).permit(:email, :phone)
    end
  
    def render_not_found
      render json: { error: 'Attendant not found' }, status: :not_found
    end
end
