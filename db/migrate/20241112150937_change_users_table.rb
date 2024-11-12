# frozen_string_literal: true

class ChangeUsersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :description, :text
  end
end
