# frozen_string_literal: true

class AddColumnDescriptionToAssistantService < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_services, :description, :text
  end
end
