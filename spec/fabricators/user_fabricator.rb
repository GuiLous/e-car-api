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
Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'password123' }
  name { Faker::Name.name }
  role { 0 }

  after_create do |user|
    Fabricate(:wallet, user: user)
  end
end
