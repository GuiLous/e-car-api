# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_submissions
#
#  id          :bigint           not null, primary key
#  description :text
#  nickname    :string           not null
#  status      :integer          default("pending"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_assistant_submissions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_706f38130e  (user_id => users.id)
#
class AssistantSubmission < ApplicationRecord
  belongs_to :user

  enum :status, {
    pending: 0,
    approved: 1,
    rejected: 2
  }
end
