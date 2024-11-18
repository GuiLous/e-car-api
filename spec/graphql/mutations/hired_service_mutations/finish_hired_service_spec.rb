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

    context 'when some errors ocurrs' do
      it 'returns error' do
        user = Fabricate :user
        hired_service = Fabricate :hired_service

        allow_any_instance_of(HiredServices::UpdateToAnalizingService).to receive(:update_to_analizing).and_raise(StandardError.new('Error'))

        variables = {
          hiredServiceId: hired_service.id
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
        data = response['errors'][0]['message']
        expect(data).to eq('SYSTEM_ERROR')
      end
    end

    context 'when no errors ocurrs' do
      it 'updates hired service to analyzing' do
        user = Fabricate :user
        hired_service = Fabricate :hired_service

        variables = {
          hiredServiceId: hired_service.id
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response['data']['finishHiredService']['message']
        expect(data).to eq('SUCCESS')
      end
    end
  end
end
