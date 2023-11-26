class ParkingLot < ApplicationRecord
    validates :email, presence: true
    validates :name, presence: true
    validates :country, presence: true
    validates :state, presence: true
    validates :city, presence: true
    validates :address, presence: true
    validates :parking_lot_id, presence: true, uniqueness: true
  
    before_validation :generate_parking_lot_id
  
    private
  
    def generate_parking_lot_id
      self.parking_lot_id ||= generate_unique_parking_lot_id
    end
  
    def generate_unique_parking_lot_id
      loop do
        id = SecureRandom.random_number(10**8)
        break id unless ParkingLot.exists?(parking_lot_id: id)
      end
    end
  end
  