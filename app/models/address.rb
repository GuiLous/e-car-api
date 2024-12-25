# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id                :bigint           not null, primary key
#  city              :string           default(""), not null
#  complement        :string
#  country           :string           default(""), not null
#  formatted_address :string           default(""), not null
#  latitude          :decimal(10, 6)   default(0.0)
#  longitude         :decimal(10, 6)   default(0.0)
#  neighborhood      :string           default(""), not null
#  number            :string           default(""), not null
#  postal_code       :string           default(""), not null
#  state             :string           default(""), not null
#  street            :string           default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_48c9e0c5a2  (user_id => users.id)
#
class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :neighborhood, :postal_code, :number, :state, :street, :formatted_address, :latitude, :longitude, presence: true
end
