# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'Assistants' do
    let(:query) do
      <<~GQL
        query {
          assistants {
            id
          }
        }
      GQL
    end

    context 'when does not exists users with assistant role' do
      it 'returns a empty array' do
        Fabricate :user, role: :customer
        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['assistants']
        expect(data.size).to eq(0)
      end
    end

    context 'when exists assistants' do
      it 'returns an arrays of assistants' do
        Fabricate :assistant

        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['assistants']
        expect(data.size).to eq(1)
      end
    end
  end

  describe 'Me' do
    let(:query) do
      <<~GQL
        query {
          me {
            id
            wallet {
              blockedCoins
              availableCoins
            }
          }
        }
      GQL
    end

    context 'when exists user' do
      it 'returns user object' do
        user = Fabricate :user
        allow(ENV).to receive(:fetch).with('LOGGED_USER_ID').and_return(user.id.to_s)
        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['me']
        expect(data).to have_key('id')
      end
    end
  end

  describe 'ServiceCategories' do
    let(:query) do
      <<~GQL
        query {
          serviceCategories {
            id
            name
            typeCategory
          }
        }
      GQL
    end

    it 'returns service categories' do
      Fabricate :service_category

      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['serviceCategories']
      expect(data.size).to eq(1)
    end
  end

  describe 'Services' do
    let(:query) do
      <<~GQL
        query {
          services {
            id
            name
            description
          }
        }
      GQL
    end

    it 'returns services' do
      Fabricate :service

      response = ProladdoreSchema.execute(query).as_json
      data = response['data']['services']
      expect(data.size).to eq(1)
    end
  end
end
