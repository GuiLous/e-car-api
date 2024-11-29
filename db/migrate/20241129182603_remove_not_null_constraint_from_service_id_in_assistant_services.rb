# frozen_string_literal: true

class RemoveNotNullConstraintFromServiceIdInAssistantServices < ActiveRecord::Migration[7.2]
  def change
    change_column_null :assistant_services, :service_id, true
  end
end
