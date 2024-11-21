# frozen_string_literal: true

class AddColumnStatusToAssistantService < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_services, :status, :integer, null: false, default: 0
  end
end
