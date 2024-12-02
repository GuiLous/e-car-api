# frozen_string_literal: true

class AddTitleToAssistantServices < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_services, :title, :string, null: false, default: ''
  end
end
