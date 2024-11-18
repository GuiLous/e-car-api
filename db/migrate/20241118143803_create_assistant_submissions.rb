class CreateAssistantSubmissions < ActiveRecord::Migration[7.2]
  def change
    create_table :assistant_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
