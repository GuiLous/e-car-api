# frozen_string_literal: true

class AddTitleToAssistantSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_submissions, :title, :string, null: false, default: ''
  end
end
