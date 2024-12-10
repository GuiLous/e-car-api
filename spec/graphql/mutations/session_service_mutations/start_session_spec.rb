# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SessionServiceMutations::StartSession do
  let(:mutation) do
    <<~GQL
      mutation($hiredServiceId: ID!) {
        startSessionService(hiredServiceId: $hiredServiceId) {
          sessionService {
            assistantStartedAt
            consumerStartedAt
            endAt
            hiredService {
              id
            }
            status
          }
        }
      }
    GQL
  end

  describe '#resolve' do
    context 'when some errors ocurrs' do
      it 'returns error' do
        user = Fabricate :user
        hired_service = Fabricate :hired_service

        allow_any_instance_of(SessionServices::SessionStartService).to receive(:start).and_raise(StandardError.new('Error'))

        variables = {
          hiredServiceId: hired_service.id
        }

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response['errors'][0]['message']
        expect(data).to eq('SYSTEM_ERROR')
      end
    end

    context 'when consumer action' do
      it 'start session with assistant' do
        user = Fabricate :user
        hired_service = Fabricate :hired_service
        session_service = Fabricate :session_service, hired_service: hired_service

        variables = {
          hiredServiceId: hired_service.id
        }

        allow_any_instance_of(SessionServices::SessionStartService).to receive(:start).and_return(session_service)

        context = { current_user: user }

        response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json

        data = response['data']['startSessionService']['sessionService']
        expect(data['assistantStartedAt']).to eq(session_service.assistant_started_at.iso8601)
        expect(data['consumerStartedAt']).to eq(session_service.consumer_started_at.iso8601)
        expect(data['endAt']).to eq(session_service.end_at.iso8601)
        expect(data['hiredService']['id']).to eq(hired_service.id.to_s)
        expect(data['status']).to eq(session_service.status)
      end
    end
  end
end
