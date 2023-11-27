class Booking < ApplicationRecord
  validates :razorpayOrderId, presence: true
  validates :razorpaySignature, presence: true
  validates :razorpayPaymentId, presence: true
  validates :parking_lot_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :phone, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending success failed) }
end