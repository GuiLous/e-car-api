# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
