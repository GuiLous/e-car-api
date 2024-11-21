# frozen_string_literal: true

# == Schema Information
#
# Table name: service_categories
#
#  id            :bigint           not null, primary key
#  image_url     :string
#  name          :string           not null
#  type_category :integer          default("game"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
Fabricator(:service_category) do
  name { Faker::Lorem.word }
  type_category { 0 }
end
