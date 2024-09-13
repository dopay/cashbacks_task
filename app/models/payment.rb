# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :different_accounts
  validate :sufficient_funds

  private

  def different_accounts
    if source_account_id == destination_account_id
      errors.add(:base, "Source and destination accounts must be different")
    end
  end

  def sufficient_funds
    if source_account && amount && source_account.amount < amount
      errors.add(:amount, "Insufficient funds in the source account")
    end
  end
end