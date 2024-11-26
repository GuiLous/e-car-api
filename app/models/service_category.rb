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
class ServiceCategory < ApplicationRecord
  has_many :assistant_service, dependent: :nullify

  enum :type_category, { game: 0 }

  validates :name, presence: true
end
