# frozen_string_literal: true

class CreateServiceCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :service_categories do |t|
      t.string :name
      t.integer :type_category, default: 0, null: false
      t.timestamps
    end
  end
end
