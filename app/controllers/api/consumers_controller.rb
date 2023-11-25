class Api::ConsumersController < ApplicationController
    before_action :set_consumer, only: [:update, :destroy, :is_any_missing_details, :consumer_details, :show]

    def show
        render json: Consumer.all
    end

    def create
      @consumer = Consumer.new(consumer_params)
  
      if @consumer.save
        render json: {
          "success" => "Consumer created successfully",
        }, status: :created
      else
        render json: @consumer.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @consumer.update(consumer_params)
        render json: @consumer
      else
        render json: @consumer.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @consumer.destroy
        head :no_content
        render json: {destroy: "success"}, status: 200
      else
      render json: @consumer.errors, status: :unprocessable_entity
      end
    end
  
    def is_any_missing_details
      if @consumer.email.blank? || @consumer.phone.blank?
        render json: { missing: true }
      else
        render json: { missing: false }
      end
    end

    def consumer_details
        render json: @consumer
      end
  
    private
  
    def set_consumer
      @consumer = Consumer.find_by(email: consumer_params[:email])
      render_not_found if @consumer.nil?
    end
  
    def consumer_params
      params.require(:consumer).permit(:email, :phone)
    end
  
    def render_not_found
      render json: { error: 'Consumer not found' }, status: :not_found
    end
end