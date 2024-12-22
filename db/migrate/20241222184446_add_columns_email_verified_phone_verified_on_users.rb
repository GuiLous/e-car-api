# frozen_string_literal: true

class AddColumnsEmailVerifiedPhoneVerifiedOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_table :users, bulk: true do |t|
      t.boolean :email_verified, null: false, default: false
      t.boolean :phone_verified, null: false, default: false
    end
  end
end
