# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_services
#
#  id           :bigint           not null, primary key
#  price        :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  assistant_id :bigint
#  service_id   :bigint           not null
#
# Indexes
#
#  index_assistant_services_on_assistant_id  (assistant_id)
#  index_assistant_services_on_service_id    (service_id)
#
# Foreign Keys
#
#  fk_rails_5c08927e25  (service_id => services.id)
#  fk_rails_ff3182149c  (assistant_id => assistants.id)
#
class AssistantService < ApplicationRecord
  belongs_to :assistant
  belongs_to :service
  has_many :hired_services, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def hire(date:, user:)
    raise Exceptions::SameUserError if assistant.user_id == user.id

    hired_services.create(schedule_date: date, user: user)
  end
end
