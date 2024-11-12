# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
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

  has_one :assistant, dependent: :destroy
  has_one :wallet, dependent: :destroy

  has_many :hired_services, dependent: :destroy

  enum :role, { customer: 0, assistant: 1 }

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  after_create :create_wallet

  def blocked_coins
    hired_services.scheduled.joins(:assistant_service).sum("assistant_services.price")
  end

  def available_coins
    wallet&.coins&.- blocked_coins
  end

  private

  def create_wallet
    Wallet.create(user: self) if wallet.nil?
  end
end
