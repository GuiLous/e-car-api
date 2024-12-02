# frozen_string_literal: true

class RemoveServiceIdFromAssistantSubmissions < ActiveRecord::Migration[7.2]
  def up
    remove_reference :assistant_submissions, :service, null: false, foreign_key: true
  end

  def down
    add_reference :assistant_submissions, :service, foreign_key: true
  end
end
