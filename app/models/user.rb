# frozen_string_literal: true

class User < ApplicationRecord
  has_many :accounts

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
