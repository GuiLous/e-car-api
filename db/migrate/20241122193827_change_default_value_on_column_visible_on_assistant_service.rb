# frozen_string_literal: true

class ChangeDefaultValueOnColumnVisibleOnAssistantService < ActiveRecord::Migration[7.2]
  def up
    change_column_default :assistant_services, :visible, 1
  end

  def down
    change_column_default :assistant_services, :visible, nil
  end
end
