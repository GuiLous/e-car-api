# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UserMutations::UpdateUserStatus do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($status: String!) {
          updateUserStatus(status: $status) {
            user {
              id
              status
            }
          }
        }
      GQL
    end

    it 'updates the user status' do
      user = Fabricate :user

      variables = {
        status: 'online'
      }

      context = { current_user: user }

      response = ProladdoreSchema.execute(mutation, variables: variables, context: context).as_json
      data = response['data']['updateUserStatus']
      expect(data['user']['status']).to eq('online')
    end
  end
end
