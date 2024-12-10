# frozen_string_literal: true

class AddColumnsOnSessionService < ActiveRecord::Migration[7.2]
  def change
    change_table :session_services, bulk: true do |t|
      t.string :channel_name, null: false, default: ""
      t.string :consumer_channel_token, null: false, default: ""
      t.string :consumer_channel_uid, null: false, default: ""
      t.string :assistant_channel_token
      t.string :assistant_channel_uid
    end
  end
end
