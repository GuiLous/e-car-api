# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::SessionServiceType do
  describe 'UserType' do
    let(:query) do
      <<~GQL
        query ($sessionServiceId: Int!) {
          sessionService(sessionServiceId: $sessionServiceId) {
            id
            status
            assistantStartedAt
            consumerStartedAt
            endAt
            assistantChannelToken
            assistantChannelUid
            consumerChannelToken
            consumerChannelUid
            channelName
            hiredService {
              id
            }
          }
        }
      GQL
    end

    context "When consumer is on the session" do
      it 'returns the expected fields for a session service' do
        user = Fabricate :user
        hired_service = Fabricate :hired_service, user: user
        session_service = Fabricate :session_service, hired_service: hired_service

        variables = { sessionServiceId: session_service.id }
        context = { current_user: user }

        response = ProladdoreSchema.execute(query, variables: variables, context: context).as_json

        data = response['data']['sessionService']

        expect(data['id']).to eq(session_service.id.to_s)
        expect(data['status']).to eq(session_service.status)
        expect(data['assistantStartedAt']).to eq(session_service.assistant_started_at.iso8601)
        expect(data['consumerStartedAt']).to eq(session_service.consumer_started_at.iso8601)
        expect(data['endAt']).to eq(session_service.end_at.iso8601)
        expect(data['assistantChannelToken']).to eq(session_service.assistant_channel_token)
        expect(data['assistantChannelUid']).to eq(session_service.assistant_channel_uid)
        expect(data['consumerChannelToken']).to eq(session_service.consumer_channel_token)
        expect(data['consumerChannelUid']).to eq(session_service.consumer_channel_uid)
        expect(data['channelName']).to eq(session_service.channel_name)
      end
    end

    context "When assistant is on the session" do
      it 'returns the expected fields for a session service' do
        assistant = Fabricate :assistant
        user = assistant.user
        hired_service = Fabricate :hired_service, user: user
        session_service = Fabricate :session_service, hired_service: hired_service

        variables = { sessionServiceId: session_service.id }
        context = { current_user: user }

        response = ProladdoreSchema.execute(query, variables: variables, context: context).as_json

        data = response['data']['sessionService']

        expect(data['id']).to eq(session_service.id.to_s)
        expect(data['status']).to eq(session_service.status)
        expect(data['assistantStartedAt']).to eq(session_service.assistant_started_at.iso8601)
        expect(data['consumerStartedAt']).to eq(session_service.consumer_started_at.iso8601)
        expect(data['endAt']).to eq(session_service.end_at.iso8601)
        expect(data['assistantChannelToken']).to eq(session_service.assistant_channel_token)
        expect(data['assistantChannelUid']).to eq(session_service.assistant_channel_uid)
        expect(data['consumerChannelToken']).to eq(session_service.consumer_channel_token)
        expect(data['consumerChannelUid']).to eq(session_service.consumer_channel_uid)
        expect(data['channelName']).to eq(session_service.channel_name)
      end
    end

    context "When user is not on the session" do
      it 'raise NOT_IN_SESSION error' do
        user = Fabricate :user
        session_service = Fabricate :session_service

        variables = { sessionServiceId: session_service.id }
        context = { current_user: user }

        response = ProladdoreSchema.execute(query, variables: variables, context: context).as_json

        data = response['errors'][0]['message']

        expect(data).to eq("NOT_IN_SESSION")
      end
    end
  end
end
