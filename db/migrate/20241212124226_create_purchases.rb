# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases do |t|
      t.string :price_id
      t.integer :status, null: false, default: 0
      t.string :price, null: false, default: '0'
      t.string :session_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
