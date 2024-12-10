# frozen_string_literal: true

# == Schema Information
#
# Table name: session_services
#
#  id                      :bigint           not null, primary key
#  assistant_channel_token :string
#  assistant_channel_uid   :string
#  assistant_started_at    :datetime
#  channel_name            :string           default(""), not null
#  consumer_channel_token  :string           default(""), not null
#  consumer_channel_uid    :string           default(""), not null
#  consumer_started_at     :datetime
#  end_at                  :datetime
#  status                  :integer          default("created")
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  hired_service_id        :bigint           not null
#
# Indexes
#
#  index_session_services_on_hired_service_id  (hired_service_id)
#
# Foreign Keys
#
#  fk_rails_cf15bea252  (hired_service_id => hired_services.id)
#
Fabricator(:session_service) do
  hired_service { Fabricate :hired_service }
  assistant_started_at { Time.current }
  consumer_started_at { Time.current }
  end_at { Time.current }
  status { 0 }
  created_at { Time.current }
  updated_at { Time.current }
end
