# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  description     :text
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  role            :integer          default("customer"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :user_services
  has_many :services, through: :user_services

  enum :role, { customer: 0, assistant: 1 }

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
