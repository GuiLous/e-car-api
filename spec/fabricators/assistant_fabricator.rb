# frozen_string_literal: true

# == Schema Information
#
# Table name: assistants
#
#  id          :bigint           not null, primary key
#  description :text
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
Fabricator(:assistant) do
  description { Faker::Lorem.sentence }
  user { Fabricate :user, role: :assistant }
end
