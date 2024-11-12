# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::HiredServiceCreate do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($assistantServiceId: ID!, $scheduleDate: ISO8601Date!) {
          hiredServiceCreate(assistantServiceId: $assistantServiceId, scheduleDate: $scheduleDate) {
            hiredService {
              id
            }
          }
        }
      GQL
    end

    it 'hire a service' do
      Fabricate :user
      assistant_service = Fabricate :assistant_service

      variables = {
        assistantServiceId: assistant_service.id,
        scheduleDate: Time.zone.today
      }

      response = ProladdoreSchema.execute(mutation, variables: variables).as_json
      data = response['data']['hiredServiceCreate']['hiredService']
      expect(data['id']).to eq(HiredService.last.id.to_s)
    end
  end
end
