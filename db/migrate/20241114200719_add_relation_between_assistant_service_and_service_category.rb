# frozen_string_literal: true

class AddRelationBetweenAssistantServiceAndServiceCategory < ActiveRecord::Migration[7.2]
  def change
    add_reference :assistant_services, :service_category, foreign_key: true
  end
end
