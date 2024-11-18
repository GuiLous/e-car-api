# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_submissions
#
#  id                  :bigint           not null, primary key
#  description         :text
#  modality            :integer          default(0), not null
#  price               :integer          default(0), not null
#  status              :integer          default("pending"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  service_category_id :bigint           not null
#  service_id          :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_assistant_submissions_on_service_category_id  (service_category_id)
#  index_assistant_submissions_on_service_id           (service_id)
#  index_assistant_submissions_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_417d992029  (service_id => services.id)
#  fk_rails_706f38130e  (user_id => users.id)
#  fk_rails_ceccd8fd93  (service_category_id => service_categories.id)
#
class AssistantSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :service_category

  enum :status, {
    pending: 0,
    approved: 1,
    rejected: 2
  }
end
