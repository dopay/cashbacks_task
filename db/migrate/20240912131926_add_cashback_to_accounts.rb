# frozen_string_literal: true

class AddCashbackToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :cashback, :boolean, default: false
  end
end
