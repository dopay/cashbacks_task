# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  before { create :payment }

  describe 'associations' do
    it { is_expected.to belong_to(:source_account).class_name('Account') }
    it { is_expected.to belong_to(:destination_account).class_name('Account') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end
end
