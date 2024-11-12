# frozen_string_literal: true

class CreateHiredServices < ActiveRecord::Migration[7.2]
  def change
    create_table :hired_services do |t|
      t.date :schedule_date, null: false
      t.integer :status, null: false, default: 0
      t.references :assistant_service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
