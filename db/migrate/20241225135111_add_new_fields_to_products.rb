# frozen_string_literal: true

class AddNewFieldsToProducts < ActiveRecord::Migration[7.2]
  def change
    change_table :products, bulk: true do |t|
      t.float :price, null: false, default: 0.0
      t.integer :discount_percentage
    end
  end
end
