# frozen_string_literal: true

class AddColumnsLastNameAndPhoneOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :last_name, null: false, default: ''
      t.string :phone, null: false, default: ''
    end
  end
end
