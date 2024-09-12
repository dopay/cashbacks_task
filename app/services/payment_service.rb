# frozen_string_literal: true

class PaymentService
    def initialize(payment_params, user)
      @payment_params = payment_params
      @user = user
      @payment = Payment.new(payment_params)
    end
  
    def process
      return false if insufficient_funds?
  
      ActiveRecord::Base.transaction do
        update_account_balances
        process_cashback
        @payment.save!
      end
  
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  
    private
  
    def insufficient_funds?
      source_account.amount < @payment.amount
    end
  
    def update_account_balances
      source_account.update!(amount: source_account.amount - @payment.amount)
      destination_account.update!(amount: destination_account.amount + @payment.amount)
    end
  
    def process_cashback
      cashback_amount = @payment.amount * 0.05
      cashback_account = @user.accounts.cashback.first_or_create!(name: 'Cashback', amount: 0, cashback: true)
      cashback_account.update!(amount: cashback_account.amount + cashback_amount)
    end
  
    def source_account
      @source_account ||= Account.find(@payment_params[:source_account_id])
    end
  
    def destination_account
      @destination_account ||= Account.find(@payment_params[:destination_account_id])
    end
  end