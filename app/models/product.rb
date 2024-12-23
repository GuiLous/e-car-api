# frozen_string_literal: true

class Product < ApplicationRecord
  enum :vehicle_type, { car_type: 0, motorcycle_type: 1 }
  enum :vehicle_condition, { brand_new: 0, used: 1 }
  enum :documentation_status, { up_to_date: 0, overdue: 1 }

  has_many_attached :images

  validates :vehicle_name, :year, :mileage, :model, presence: true
  validates :images, length: { maximum: 5, message: "only up to 5 images are allowed" }
end
