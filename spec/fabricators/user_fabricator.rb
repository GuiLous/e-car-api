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
Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'Taller@123' }
  first_name { Faker::Name.name }
  last_name { Faker::Name.name }
  phone { Faker::PhoneNumber.phone_number }
end
