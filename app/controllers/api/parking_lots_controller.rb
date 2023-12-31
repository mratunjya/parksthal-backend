class Api::ParkingLotsController < ApplicationController
  before_action :set_parking_lot, only: [:show, :delete, :update_parking_lot]

  def create
    @parking_lot = ParkingLot.new(parking_lot_params)

    if @parking_lot.save
      render json: { success: 'Parking lot created successfully', parking_lot: @parking_lot }, status: :created
    else
      render json: { errors: @parking_lot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user_email = params[:email]
    booked_parking_lot_ids_today = Booking.where(email: user_email, created_at: Date.today.all_day).pluck(:parking_lot_id)
  
    parking_lots = ParkingLot.all.map do |parking_lot|
      total_bookings_today = Booking.where(parking_lot_id: parking_lot.parking_lot_id, created_at: Date.today.all_day).count
  
      # Convert UTC to IST
      created_at_ist = parking_lot.created_at.in_time_zone('Asia/Kolkata')
  
      {
        id: parking_lot.id,
        email: parking_lot.email,
        name: parking_lot.name,
        country: parking_lot.country,
        state: parking_lot.state,
        city: parking_lot.city,
        address: parking_lot.address,
        parking_lot_id: parking_lot.parking_lot_id,
        created_at: created_at_ist,
        updated_at: parking_lot.updated_at,
        booked: total_bookings_today,
        total_capacity: parking_lot.total_capacity,
        price: parking_lot.price,
        booked_today: booked_parking_lot_ids_today.include?(parking_lot.parking_lot_id.to_s)
      }
    end
  
    render json: parking_lots
  end
  

  def update_parking_lot
    if @parking_lot.update(parking_lot_params)
      render json: { success: 'Parking lot updated successfully', parking_lot: @parking_lot }
    else
      render json: { errors: @parking_lot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    if(@parking_lot.destroy)
      render json: { success: 'Parking lot deleted successfully' }, status: 200
    else
      render json: { errors: @parking_lot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index_by_email
    email = params[:email]
    parking_lots = ParkingLot.where(email: email).all.map do |parking_lot|
      total_bookings_today = Booking.where(parking_lot_id: parking_lot.parking_lot_id, created_at: Date.today.all_day).count

      # Convert UTC to IST
      created_at_ist = parking_lot.created_at.in_time_zone('Asia/Kolkata')
      {
        id: parking_lot.id,
        email: parking_lot.email,
        name: parking_lot.name,
        country: parking_lot.country,
        state: parking_lot.state,
        city: parking_lot.city,
        address: parking_lot.address,
        parking_lot_id: parking_lot.parking_lot_id,
        created_at: created_at_ist,
        updated_at: parking_lot.updated_at,
        booked: total_bookings_today,
        total_capacity: parking_lot.total_capacity,
        price: parking_lot.price,
      }
    end
    render json: parking_lots
  end

  private

  def set_parking_lot
    @parking_lot = ParkingLot.find_by(parking_lot_id: params[:parking_lot_id])
  end

  def parking_lot_params
    params.require(:parking_lot).permit(:email, :name, :country, :state, :city, :address, :total_capacity, :price)
  end
end