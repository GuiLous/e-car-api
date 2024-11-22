# frozen_string_literal: true

class RenameStatusToVisibleInAssistantServices < ActiveRecord::Migration[7.2]
  def change
    rename_column :assistant_services, :status, :visible
  end
end
