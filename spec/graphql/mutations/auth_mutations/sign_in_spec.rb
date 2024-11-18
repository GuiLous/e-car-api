# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AuthMutations::SignIn do
  describe '#resolve' do
    let(:mutation) do
      <<~GQL
        mutation($email: String!, $password: String!) {
          signIn(email: $email, password: $password) {
            token
          }
        }
      GQL
    end

    context 'when credentials are valid' do
      it 'returns a token' do
        user = Fabricate :user

        variables = {
          email: user.email,
          password: user.password
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        data = response['data']['signIn']
        expect(data['token']).to be_present
      end
    end

    context 'when an error occurs' do
      it 'returns an INVALID_CREDENTIALS error' do
        user = Fabricate :user

        variables = {
          email: user.email,
          password: 'invalid_password'
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('INVALID_CREDENTIALS')
      end

      it 'returns an SYSTEM_ERROR error' do
        allow(AuthServices::SignInService.instance).to receive(:sign_in).and_raise(StandardError, 'SYSTEM_ERROR')

        variables = {
          email: 'invalid_email',
          password: 'invalid_password'
        }

        response = ProladdoreSchema.execute(mutation, variables: variables).as_json
        error_message = response['errors'].first['message']
        expect(error_message).to eq('SYSTEM_ERROR')
      end
    end
  end
end
