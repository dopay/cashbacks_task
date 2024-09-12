FactoryBot.define do
  factory :transaction do
    account { nil }
    amount { "9.99" }
    transaction_type { "MyString" }
    description { "MyText" }
  end
end
