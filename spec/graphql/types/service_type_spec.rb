# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::ServiceType do
  describe 'ServiceType' do
    let(:query) do
      <<~GQL
        query {
          assistantServices {
            service {
              description
              id
              name
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      assistant_service = Fabricate :user_service
      service = assistant_service.service
      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['assistantServices'][0]['service']

      expect(data['id']).to eq(service.id.to_s)
      expect(data['name']).to eq(service.name)
      expect(data['description']).to eq(service.description)
    end
  end
end
