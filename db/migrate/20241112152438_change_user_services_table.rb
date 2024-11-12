# frozen_string_literal: true

class ChangeUserServicesTable < ActiveRecord::Migration[7.2]
  def change
    remove_reference :user_services, :user, foreign_key: true

    add_reference :user_services, :assistant, foreign_key: true

    rename_table :user_services, :assistant_services
  end
end
