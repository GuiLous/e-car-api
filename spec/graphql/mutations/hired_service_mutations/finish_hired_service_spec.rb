# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::HiredServiceMutations::FinishHiredService do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($hiredServiceId: ID!) {
          finishHiredService(hiredServiceId: $hiredServiceId) {
            message
          }
        }
      GQL
    end

    it 'updates hired service to analyzing' do
      hired_service = Fabricate :hired_service

      variables = {
        hiredServiceId: hired_service.id
      }

      response = ProladdoreSchema.execute(mutation, variables: variables).as_json

      data = response['data']['finishHiredService']['message']
      expect(data).to eq('SUCCESS')
    end
  end
end
