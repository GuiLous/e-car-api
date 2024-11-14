# frozen_string_literal: true

class AddColumnStatusToAssistant < ActiveRecord::Migration[7.2]
  def change
    add_column :assistants, :status, :integer, default: 0, null: false
  end
end
