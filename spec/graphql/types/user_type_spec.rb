# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::UserType do
  describe 'UserType' do
    let(:query) do
      <<~GQL
        query {
          me {
            email
            firstName
            id
            lastName
            phone
          }
        }
      GQL
    end

    it 'returns the expected fields for a user' do
      user = Fabricate :user

      context = { current_user: user }

      response = EcarSchema.execute(query, context: context).as_json
      data = response['data']['me']

      expect(data['id']).to eq(user.id.to_s)
      expect(data['email']).to eq(user.email.to_s)
    end
  end
end
