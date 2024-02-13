# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :amount

      t.belongs_to :source_account, index: true
      t.belongs_to :destination_account, index: true

      t.timestamps
    end
  end
end
