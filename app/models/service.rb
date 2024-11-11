# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Service < ApplicationRecord
  has_many :user_services, dependent: :destroy
  has_many :users, through: :user_services

  validates :name, :description, presence: true
end
