# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.decimal :amount, null: false, default: 0
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
