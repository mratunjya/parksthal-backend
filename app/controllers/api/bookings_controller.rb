# app/controllers/api/bookings_controller.rb
class Api::BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :update, :destroy]
  
    def index
        user_email = params[:email]
        bookings = Booking.where(email: user_email).map do |booking|
          parking_lot = ParkingLot.find_by(parking_lot_id: booking.parking_lot_id)

          # Convert UTC to IST
          created_at_ist = booking.created_at.in_time_zone('Asia/Kolkata')

          {
            price: booking.price, # Assuming 'price' is an attribute of Booking
            name: parking_lot&.name, # Assuming 'name' is an attribute of ParkingLot
            status: booking.status,
            address: parking_lot&.address, # Assuming 'address' is an attribute
            city: parking_lot&.city, # Assuming 'city' is an
            created_at: created_at_ist
          }
        end
      
        render json: bookings
    end
  
    def create
      @booking = Booking.new(booking_params)
  
      if @booking.save
        render json: { success: 'Booking created successfully', booking: @booking }, status: :created
      else
        render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @booking.update(booking_params)
        render json: @booking
      else
        render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @booking.destroy
      head :no_content
    end
  
    private
  
    def set_booking
      @booking = Booking.find(params[:id])
      render_not_found unless @booking
    end
  
    def booking_params
      params.require(:booking).permit(:razorpayOrderId, :razorpaySignature, :razorpayPaymentId, :parking_lot_id, :price, :phone, :email, :name, :status)
    end
  
    def render_not_found
      render json: { error: 'Booking not found' }, status: :not_found
    end
  end
  