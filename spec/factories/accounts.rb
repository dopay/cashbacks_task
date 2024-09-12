# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    user

    name { 'MyString' }
    amount { '9.99' }
    cashback { false }

    trait :cashback do
      name { 'Cashback' }
      cashback { true }
    end
  end
end