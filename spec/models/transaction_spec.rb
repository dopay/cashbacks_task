# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:account) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:transaction_type) }
  it { should validate_inclusion_of(:transaction_type).in_array(%w[credit debit]) }

  describe 'scopes' do
    let!(:credit_transaction) { create(:transaction, transaction_type: 'credit') }
    let!(:debit_transaction) { create(:transaction, transaction_type: 'debit') }

    it 'returns only credit transactions' do
      expect(Transaction.credits).to include(credit_transaction)
      expect(Transaction.credits).not_to include(debit_transaction)
    end

    it 'returns only debit transactions' do
      expect(Transaction.debits).to include(debit_transaction)
      expect(Transaction.debits).not_to include(credit_transaction)
    end
  end
end