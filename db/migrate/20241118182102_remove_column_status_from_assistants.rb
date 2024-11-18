# frozen_string_literal: true

class RemoveColumnStatusFromAssistants < ActiveRecord::Migration[7.2]
  def change
    remove_column :assistants, :status, :integer, null: false, default: 0
  end
end
