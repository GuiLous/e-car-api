# frozen_string_literal: true

class RemoveColumnStatusAdnNicknameFromAssistants < ActiveRecord::Migration[7.2]
  def up
    change_table :assistants, bulk: true do |t|
      t.remove :status, :nickname
    end
  end

  def down
    change_table :assistants, bulk: true do |t|
      t.string :nickname
      t.integer :status, null: false, default: 0
    end
  end
end
