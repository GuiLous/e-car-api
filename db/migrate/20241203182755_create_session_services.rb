# frozen_string_literal: true

class CreateSessionServices < ActiveRecord::Migration[7.2]
  def change
    create_table :session_services do |t|
      t.references :hired_service, null: false, foreign_key: true
      t.datetime :assistant_started_at
      t.datetime :consumer_started_at
      t.datetime :end_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
