# frozen_string_literal: true

class AddColumnStartDateAnalysisToHiredService < ActiveRecord::Migration[7.2]
  def change
    add_column :hired_services, :analysis_started_at, :datetime
  end
end
