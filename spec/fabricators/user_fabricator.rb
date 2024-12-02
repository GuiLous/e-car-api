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
Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'Taller@123' }
  name { Faker::Name.name }
  role { 0 }
  online_at { Time.current }

  after_create do |user|
    Fabricate(:wallet, user: user)
  end
end
