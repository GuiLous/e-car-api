# frozen_string_literal: true

# == Schema Information
#
# Table name: assistants
#
#  id          :bigint           not null, primary key
#  description :text
#  nickname    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_assistants_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_9ac4b9e2cd  (user_id => users.id)
#
class Assistant < ApplicationRecord
  belongs_to :user
  has_many :assistant_services, dependent: :destroy
  has_many :services, through: :assistant_services
  has_many :hired_services, through: :assistant_services
end
