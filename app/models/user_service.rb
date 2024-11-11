# frozen_string_literal: true

# == Schema Information
#
# Table name: user_services
#
#  id         :bigint           not null, primary key
#  price      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  service_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_services_on_service_id  (service_id)
#  index_user_services_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_061e6d355b  (service_id => services.id)
#  fk_rails_fea9a826f7  (user_id => users.id)
#
class UserService < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
