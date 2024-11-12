# frozen_string_literal: true

class CreateAssistants < ActiveRecord::Migration[7.2]
  def change
    create_table :assistants do |t|
      t.string :nickname
      t.text :description

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
