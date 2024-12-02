# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AssistantSubmissionType do
  describe 'AssistantType' do
    let(:query) do
      <<~GQL
        query {
          me {
            assistantSubmission {
              description
              id
              modality
              price
              serviceCategory {
                id
              }
              status
              user {
                id
              }
            }
          }
        }
      GQL
    end

    it 'returns the expected fields for a assistant submission' do
      user = Fabricate :user
      submission = Fabricate :assistant_submission, user: user, title: 'I am an assistant', description: 'xpto', modality: 0, price: 100, status: :pending

      context = { current_user: user }
      response = ProladdoreSchema.execute(query, context: context).as_json

      data = response['data']['me']['assistantSubmission']

      expect(data['id']).to eq(submission.id.to_s)
      expect(data['description']).to eq(submission.description)
      expect(data['modality']).to eq('0')
      expect(data['price']).to eq(100)
      expect(data['status']).to eq('pending')
      expect(data['user']['id']).to eq(submission.user.id.to_s)
    end
  end
end
