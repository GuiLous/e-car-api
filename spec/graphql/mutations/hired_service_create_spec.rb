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

    context 'when is another user' do
      it 'hire a service' do
        user = Fabricate :user
        user.wallet.update(coins: 10)
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

    context 'when InsufficientCoinsError is raised' do
      it 'returns a insufficient coins error' do
        Fabricate :user
        assistant_service = Fabricate :assistant_service, price: 10

        variables = {
          assistantServiceId: assistant_service.id,
          scheduleDate: Time.zone.today
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('INSUFFICIENT_COINS')
      end
    end

    context 'when SameUserError is raised' do
      it 'returns a same user error' do
        assistant_service = Fabricate :assistant_service

        variables = {
          assistantServiceId: assistant_service.id,
          scheduleDate: Time.zone.today
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('SAME_USER_ERROR')
      end
    end

    context 'when a StandardError is raised' do
      it 'returns a system error' do
        allow(HireAssistantService::CreateService.instance).to receive(:create).and_raise(StandardError, 'SYSTEM_ERROR')

        variables = {
          assistantServiceId: 9999,
          scheduleDate: Time.zone.today
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('SYSTEM_ERROR')
      end
    end
  end
end
