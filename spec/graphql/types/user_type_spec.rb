# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::UserType do
  describe 'UserType' do
    let(:query) do
      <<~GQL
        query {
          assistants {
            user {
              id
              name
              email
              role
              assistantSubmission {
                id
              }
              assistant {
                id
              }
              wallet {
                id
              }
              assistantServices {
                id
                assistant {
                  id
                }
              }
              hiredServices {
                id
              }
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      assistant = Fabricate :assistant
      user = assistant.user
      submission = Fabricate :assistant_submission, description: 'xpto', user: user
      service = Fabricate :service

      Fabricate :assistant_service, assistant: assistant, service: service
      hired_service = Fabricate :hired_service, user: user, created_at: 1.day.ago
      another_hired_service = Fabricate :hired_service, user: user, created_at: Time.current

      another_user = Fabricate :user
      another_assistant = Fabricate :assistant, user: another_user
      Fabricate :assistant_service, assistant: another_assistant, service: service

      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['assistants'][0]['user']

      expect(data['id']).to eq(user.id.to_s)
      expect(data['name']).to eq(user.name)
      expect(data['email']).to eq(user.email)
      expect(data['role']).to eq(user.role)
      expect(data['assistant']['id']).to eq(assistant.id.to_s)
      expect(data['wallet']['id']).to eq(user.wallet.id.to_s)
      expect(data['assistantSubmission']['id']).to eq(submission.id.to_s)
      expect(data['assistantServices'].count).to eq(1)
      expect(data['hiredServices'].count).to eq(2)
      expect(data['hiredServices'].first['id']).to eq(another_hired_service.id.to_s)
      expect(data['hiredServices'].last['id']).to eq(hired_service.id.to_s)
    end
  end
end
