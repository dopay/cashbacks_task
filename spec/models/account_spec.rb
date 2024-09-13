# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:payments).with_foreign_key('source_account_id') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe 'scopes' do
    describe '.cashback' do
      let!(:regular_account) { create(:account) }
      let!(:cashback_account) { create(:account, :cashback) }

      it 'returns only cashback accounts' do
        expect(described_class.cashback).to include(cashback_account)
        expect(described_class.cashback).not_to include(regular_account)
      end
    end
  end
end