# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::UserType do
  describe 'UserType' do
    let(:query) do
      <<~GQL
        query {
          assistants {
            id
            name
            email
            role
            createdAt
            updatedAt
            description
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      user = Fabricate :user, role: :assistant

      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['assistants'][0]

      expect(data['id']).to eq(user.id.to_s)
      expect(data['name']).to eq(user.name)
      expect(data['email']).to eq(user.email)
      expect(data['role']).to eq(user.role)
      expect(data['createdAt']).to eq(user.created_at.iso8601)
      expect(data['updatedAt']).to eq(user.updated_at.iso8601)
      expect(data['description']).to eq(user.description)
    end
  end
end
