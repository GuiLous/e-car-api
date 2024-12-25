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
#  verified_status      :integer          default("pending"), not null
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
class Product < ApplicationRecord
  enum :vehicle_type, { car_type: 0, motorcycle_type: 1 }
  enum :vehicle_condition, { brand_new: 0, used: 1 }
  enum :documentation_status, { up_to_date: 0, overdue: 1 }
  enum :verified_status, { pending: 0, approved: 1, reproved: 2 }

  belongs_to :user

  has_many_attached :images

  validates :vehicle_name, :year, :mileage, :model, presence: true
  validates :images, length: { maximum: 5, message: "only up to 5 images are allowed" }
end
