# frozen_string_literal: true

class ChangeNameNullConstraintInServiceCategories < ActiveRecord::Migration[7.2]
  def change
    change_column_null :service_categories, :name, false
  end
end
