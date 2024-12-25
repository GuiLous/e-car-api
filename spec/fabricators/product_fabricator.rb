# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                   :bigint           not null, primary key
#  documentation_status :integer          default("up_to_date"), not null
#  mileage              :integer          not null
#  model                :string           not null
#  vehicle_condition    :integer          default("brand_new"), not null
#  vehicle_name         :string           not null
#  vehicle_type         :integer          default("car_type"), not null
#  year                 :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
Fabricator(:product) do
  vehicle_type { 0 }
  vehicle_condition { 0 }
  documentation_status { 0 }
  vehicle_name { Faker::Vehicle.make }
  year { Faker::Vehicle.year }
  mileage { Faker::Vehicle.mileage }
  model { Faker::Vehicle.model }
  user { Fabricate(:user) }
end
