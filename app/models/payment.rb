# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'

  validates :amount, presence: true
end
