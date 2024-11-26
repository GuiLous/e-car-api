# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_services
#
#  id                  :bigint           not null, primary key
#  description         :text
#  modality            :integer          default("live"), not null
#  price               :integer          default(0), not null
#  visible             :integer          default("visible"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  assistant_id        :bigint
#  service_category_id :bigint
#  service_id          :bigint           not null
#
# Indexes
#
#  index_assistant_services_on_assistant_id         (assistant_id)
#  index_assistant_services_on_service_category_id  (service_category_id)
#  index_assistant_services_on_service_id           (service_id)
#
# Foreign Keys
#
#  fk_rails_5c08927e25  (service_id => services.id)
#  fk_rails_bfa43fb65f  (service_category_id => service_categories.id)
#  fk_rails_ff3182149c  (assistant_id => assistants.id)
#
class AssistantService < ApplicationRecord
  belongs_to :assistant
  belongs_to :service

  has_one :service_category, dependent: :nullify
  has_many :hired_services, dependent: :destroy

  enum :modality, { live: 0, closed_package: 1 }
  enum :visible, { hidden: 0, visible: 1 }

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def hire(date:, user:)
    raise Exceptions::SameUserError if assistant.user_id == user.id

    hired_services.create(schedule_date: date, user: user)
  end
end
