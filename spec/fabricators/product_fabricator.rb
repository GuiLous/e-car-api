# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                   :bigint           not null, primary key
#  discount_percentage  :integer
#  documentation_status :integer          default("up_to_date"), not null
#  mileage              :integer          not null
#  model                :string           not null
#  price                :float            default(0.0), not null
#  vehicle_condition    :integer          default("brand_new"), not null
#  vehicle_name         :string           not null
#  vehicle_type         :integer          default("car_type"), not null
#  year                 :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_dee2631783  (user_id => users.id)
#
Fabricator(:product) do
  vehicle_type { 0 }
  vehicle_condition { 0 }
  documentation_status { 0 }
  vehicle_name { Faker::Vehicle.make }
  year { Faker::Vehicle.year }
  mileage { Faker::Vehicle.mileage }
  model { Faker::Vehicle.model }
  price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  user { Fabricate(:user) }
end
