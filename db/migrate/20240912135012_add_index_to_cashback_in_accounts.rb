# frozen_string_literal: true

class AddIndexToCashbackInAccounts < ActiveRecord::Migration[7.0]
  def change
    add_index :accounts, :cashback
  end
end
