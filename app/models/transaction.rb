# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[credit debit] }

  scope :credits, -> { where(transaction_type: 'credit') }
  scope :debits, -> { where(transaction_type: 'debit') }
end