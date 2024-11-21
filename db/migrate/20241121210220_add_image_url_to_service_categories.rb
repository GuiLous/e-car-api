# frozen_string_literal: true

class AddImageUrlToServiceCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :service_categories, :image_url, :string
  end
end
