# frozen_string_literal: true

class ChangeNameToFirstNameOnUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :name, :first_name
  end
end
