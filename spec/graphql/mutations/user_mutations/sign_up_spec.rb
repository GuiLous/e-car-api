# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::UserMutations::SignUp do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($email: String!, $password: String!, $passwordConfirmation: String!, $firstName: String!, $lastName: String!, $phone: String!) {
          signUp(email: $email, password: $password, passwordConfirmation: $passwordConfirmation, firstName: $firstName, lastName: $lastName, phone: $phone) {
            token
          }
        }
      GQL
    end

    it 'returns a token' do
      variables = {
        email: 'test@example.com',
        password: '123456',
        passwordConfirmation: '123456',
        firstName: 'xpto',
        lastName: 'xpto',
        phone: 'xpto'
      }

      response = EcarSchema.execute(mutation, variables: variables).as_json
      data = response['data']['signUp']

      expect(data['token']).to be_present
    end
  end
end
