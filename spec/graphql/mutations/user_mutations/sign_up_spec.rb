# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UserMutations::SignUp do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($email: String!, $password: String!, $passwordConfirmation: String!, $role: String!, $name: String!) {
          signUp(email: $email, password: $password, passwordConfirmation: $passwordConfirmation, role: $role, name: $name) {
            token
          }
        }
      GQL
    end

    it 'returns a token' do
      variables = {
        email: 'test@example.com',
        password: 'password',
        passwordConfirmation: 'password',
        name: 'Test User',
        role: 'customer'
      }

      response = ProladdoreSchema.execute(mutation, variables: variables).as_json
      data = response['data']['signUp']
      expect(data['token']).to be_present
    end
  end
end
