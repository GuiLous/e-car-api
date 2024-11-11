# frozen_string_literal: true

class CreateUserServices < ActiveRecord::Migration[7.2]
  def change
    create_table :user_services do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :price, null: false, default: 0

      t.timestamps
    end
  end
end
