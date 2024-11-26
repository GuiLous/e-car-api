# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           not null
#  name                   :string           not null
#  online_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_one :assistant, dependent: :destroy
  has_one :wallet, dependent: :destroy

  has_many :hired_services, dependent: :destroy
  has_many :assistant_submissions, dependent: :destroy

  enum :role, { customer: 0, assistant: 1 }

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def online
    return false if online_at.nil?

    (Time.current - online_at) <= 3.minutes
  end

  def generate_jwt
    JWT.encode(
      {
        id: id,
        role: role,
        email: email,
        name: name,
        exp: 24.hours.from_now.to_i
      },
      ENV.fetch("DEVISE_JWT_SECRET_KEY")
    )
  end

  def as_json(options = {})
    super.merge(online: online)
  end
end
