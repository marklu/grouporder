class PaymentsController < ApplicationController
  def confirm
    @payment = Payment.find_by_checkout_id(params[:checkout_id])
    @payment.confirm
  end

  def thanks
  end
end
