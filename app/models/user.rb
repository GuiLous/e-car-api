# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  email_verified         :boolean          default(FALSE), not null
#  encrypted_password     :string           not null
#  first_name             :string           not null
#  last_name              :string           default(""), not null
#  phone                  :string           default(""), not null
#  phone_verified         :boolean          default(FALSE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :products, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :first_name, :email, presence: true
  validates :last_name, :email, presence: true
  validates :phone, :email, presence: true
  validates :email, uniqueness: true

  def generate_jwt
    JWT.encode(
      {
        id: id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone,
        exp: 24.hours.from_now.to_i
      },
      ENV.fetch("DEVISE_JWT_SECRET_KEY")
    )
  end
end
