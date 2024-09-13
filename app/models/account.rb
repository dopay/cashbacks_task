# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :payments, foreign_key: 'source_account_id'
  has_many :transactions

  validates :name, :amount, presence: true
  validates :name, uniqueness: { scope: :user }

  scope :cashback, -> { where(cashback: true) }
end