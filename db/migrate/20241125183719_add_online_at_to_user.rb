class AddOnlineAtToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :online_at, :datetime, null: true
  end
end
