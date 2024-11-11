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
Fabricator(:service) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
end
