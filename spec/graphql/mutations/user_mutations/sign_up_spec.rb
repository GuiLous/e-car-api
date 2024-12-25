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

    context "when no errors occurs" do
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

    context "when errors occurs" do
      context "when an StandardError occurs" do
        it 'raise SYSTEM_ERROR' do
          allow(UserServices::CreateService.instance).to receive(:create).and_raise(StandardError, 'SYSTEM_ERROR')

          variables = {
            email: 'test@example.com',
            password: '123456',
            passwordConfirmation: '123456',
            firstName: 'xpto',
            lastName: 'xpto',
            phone: 'xpto'
          }

          response = EcarSchema.execute(mutation, variables: variables).as_json
          data = response['errors'][0]

          expect(data['message']).to eq 'SYSTEM_ERROR'
        end
      end
    end
  end
end
