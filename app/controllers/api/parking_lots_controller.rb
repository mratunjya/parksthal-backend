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
    render json: ParkingLot.all
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
    parking_lots = ParkingLot.where(email: email)
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