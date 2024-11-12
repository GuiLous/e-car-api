# frozen_string_literal: true

# == Schema Information
#
# Table name: hired_services
#
#  id                   :bigint           not null, primary key
#  schedule_date        :date             not null
#  status               :integer          default("scheduled"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  assistant_service_id :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_hired_services_on_assistant_service_id  (assistant_service_id)
#  index_hired_services_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_0731374010  (assistant_service_id => assistant_services.id)
#  fk_rails_0aeb741753  (user_id => users.id)
#
class HiredService < ApplicationRecord
  enum :status, { scheduled: 0 }

  belongs_to :assistant_service
  belongs_to :user
end
