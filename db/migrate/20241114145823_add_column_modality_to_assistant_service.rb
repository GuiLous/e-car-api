# frozen_string_literal: true

class AddColumnModalityToAssistantService < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_services, :modality, :integer, default: 0, null: false
  end
end
