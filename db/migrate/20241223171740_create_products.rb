# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :vehicle_name, null: false
      t.integer :vehicle_type, null: false, default: 0
      t.integer :year, null: false
      t.integer :vehicle_condition, null: false, default: 0
      t.integer :mileage, null: false
      t.string :model, null: false
      t.integer :documentation_status, null: false, default: 0

      t.timestamps
    end
  end
end
