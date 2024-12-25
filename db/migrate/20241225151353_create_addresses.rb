# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :street, null: false, default: ''
      t.string :complement
      t.string :neighborhood, null: false, default: ''
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :postal_code, null: false, default: ''
      t.string :country, null: false, default: ''
      t.string :number, null: false, default: ''
      t.string :formatted_address, null: false, default: ''
      t.decimal :latitude, precision: 10, scale: 6, default: 0
      t.decimal :longitude, precision: 10, scale: 6, default: 0

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
