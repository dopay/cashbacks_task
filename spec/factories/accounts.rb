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

    trait :with_transactions do
      after(:create) do |account|
        create_list(:transaction, 3, account: account)
      end
    end
  end
end