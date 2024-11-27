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

    def query_find_assistant(id)
      <<~GQL
        query {
          assistant(id: #{id}) {
            id
            assistantServices {
              id
              imageUrl
            }
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

    context 'when send assistant id as parameter' do
      it 'return an unique assistant' do
        service_category = Fabricate :service_category
        service = Fabricate :service
        assistant = Fabricate :assistant

        Fabricate :assistant_service, assistant: assistant, service: service, service_category_id: service_category.id, visible: :hidden

        response = ProladdoreSchema.execute(query_find_assistant(assistant.id)).as_json

        data = response['data']['assistant']

        expect(data).to have_key('id')
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

        context = { current_user: user }

        response = ProladdoreSchema.execute(query, context: context).as_json
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
      user = Fabricate :user

      Fabricate :service_category

      context = { current_user: user }

      response = ProladdoreSchema.execute(query, context: context).as_json
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

      user = Fabricate :user

      context = { current_user: user }

      response = ProladdoreSchema.execute(query, context: context).as_json
      data = response['data']['services']
      expect(data.size).to eq(1)
    end
  end
end
