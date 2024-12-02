# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_services
#
#  id                  :bigint           not null, primary key
#  description         :text
#  modality            :integer          default("live"), not null
#  price               :integer          default(0), not null
#  title               :string           default(""), not null
#  visible             :integer          default("visible"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  assistant_id        :bigint
#  service_category_id :bigint
#  service_id          :bigint
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
Fabricator(:assistant_service) do
  price { 0 }
  assistant { Fabricate :assistant }
  visible { :visible }
  description { Faker::Lorem.paragraph(sentence_count: 2) }
  title { Faker::Lorem.word }
  service_category { Fabricate :service_category }
end
