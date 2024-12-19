# frozen_string_literal: true

class RemoveOnlineAtFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :online_at, :datetime
  end
end
