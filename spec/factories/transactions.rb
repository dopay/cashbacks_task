# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    account
    amount { "9.99" }
    transaction_type { %w[credit debit].sample }
    description { "MyText" }
  end
end