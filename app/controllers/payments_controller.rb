# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :load_user

  def new
    @payment = Payment.new
  end

  def create
    service = PaymentService.new(payment_params, @user)

    if service.process
      redirect_to user_account_path(@user, source_account), notice: 'Payment was successfully created.'
    else
      @payment = Payment.new(payment_params)
      @payment.valid? # Trigger validations to show errors
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def payment_params
    params.require(:payment).permit(:source_account_id, :destination_account_id, :amount)
  end

  def source_account
    @source_account ||= Account.find(payment_params[:source_account_id])
  end
end