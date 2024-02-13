# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    source_account { create :account }
    destination_account { create :account }
    amount { '9.99' }
  end
end
