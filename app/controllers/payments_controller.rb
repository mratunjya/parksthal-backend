# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
    def orders
      # Uncomment the following code once you've validated the amount
      amount = params[:amount] || (request.request_parameters.present? ? request.request_parameters[:amount] : nil)
  
      if amount.nil?
        render json: { error: 'Amount is required' }, status: :unprocessable_entity
        return
      end
  
      # Logic to create a new order and retrieve order details from Razorpay
      # Ensure you have the necessary Razorpay gem installed

      Razorpay.setup('rzp_test_UDwFdg9fbuz7EH', 'xkwcwYbuIa2GCTYZlHRQ2l3D')

      order = Razorpay::Order.create(
        amount: amount.to_i * 100,  # Convert amount to paise
        currency: 'INR',
        receipt: 'order_receipt',
        payment_capture: 1
      )
  
      render json: order, status: :ok
    end
  
    def success
      # Logic to handle successful payment
      # You can save payment details to your database here
  
      render json: { msg: 'Payment successful' }, status: :ok
    end
  end
  