class AddDeadlineToAssistantServices < ActiveRecord::Migration[7.2]
  def change
    add_column :assistant_services, :deadline, :string
  end

  def down
    remove_column :assistant_services, :deadline
  end
end
