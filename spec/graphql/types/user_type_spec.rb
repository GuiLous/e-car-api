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
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      assistant = Fabricate :assistant
      user = assistant.user
      submission = Fabricate :assistant_submission, description: 'xpto'

      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['assistants'][0]['user']

      expect(data['id']).to eq(user.id.to_s)
      expect(data['name']).to eq(user.name)
      expect(data['email']).to eq(user.email)
      expect(data['role']).to eq(user.role)
      expect(data['assistant']['id']).to eq(assistant.id.to_s)
      expect(data['wallet']['id']).to eq(user.wallet.id.to_s)
      expect(data['assistantSubmission']['id']).to eq(submission.id.to_s)
    end
  end
end
