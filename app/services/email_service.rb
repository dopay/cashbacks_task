# frozen_string_literal: true

class EmailService
  def self.send_payment_confirmation(payment)
    UserMailer.payment_confirmation(payment).deliver_now
  end

  def self.send_low_balance_alert(account, threshold = 100)
    return unless account.amount < threshold

    UserMailer.low_balance_alert(account).deliver_now
  end

  def self.send_cashback_notification(account, cashback_amount)
    UserMailer.cashback_notification(account, cashback_amount).deliver_now
  end
end
