# frozen_string_literal: true

class CreateAssistantSubmissions < ActiveRecord::Migration[7.2]
  def change
    create_table :assistant_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.integer :status, null: false, default: 0
      t.references :service, null: false, foreign_key: true
      t.references :service_category, null: false, foreign_key: true
      t.integer :modality, null: false, default: 0
      t.integer :price, null: false, default: 0

      t.timestamps
    end
  end
end
