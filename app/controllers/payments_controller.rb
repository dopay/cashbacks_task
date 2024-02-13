# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :load_user
  before_action :load_payment, only: %i[show edit update destroy]

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new payment_params

    if source_account.amount < @payment.amount
      @payment.errors.add :amount, "Can't be more than source account amount"
      render :new, status: :unprocessable_entity
      return nil
    end

    unless destination_account.update(amount: destination_account.amount - @payment.amount)
      @payment.errors.add :base, "Can't update destination account balance"
      render :new, status: :unprocessable_entity
      return nil
    end

    unless source_account.update(amount: source_account.amount - @payment.amount)
      @payment.errors.add :base, "Can't update source account balance"
      render :new, status: :unprocessable_entity
      return nil
    end

    if @payment.save
      redirect_to user_account_path(@user, source_account)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = User.find params[:user_id]
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:source_account_id, :destination_account_id, :amount)
  end

  def source_account
    @source_account ||= Account.find payment_params[:source_account_id]
  end

  def destination_account
    @destination_account ||= Account.find payment_params[:destination_account_id]
  end
end
