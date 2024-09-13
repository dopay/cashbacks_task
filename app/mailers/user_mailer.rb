# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def payment_confirmation(payment)
    @payment = payment
    @user = payment.source_account.user
    mail(to: @user.email, subject: 'Payment Confirmation')
  end

  def low_balance_alert(account)
    @account = account
    @user = account.user
    mail(to: @user.email, subject: 'Low Balance Alert')
  end

  def cashback_notification(account, cashback_amount)
    @account = account
    @user = account.user
    @cashback_amount = cashback_amount
    mail(to: @user.email, subject: 'Cashback Earned!')
  end
end
