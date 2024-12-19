# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::AssistantServiceType do
  describe 'AssistantServiceType' do
    let(:query) do
      <<~GQL
        query($filters: AssistantServiceFilters) {
          assistantServices(filters: $filters) {
            id
            price
            visible
            imageUrl
            assistant {
              id
            }
          }
        }
      GQL
    end

    context 'when the assistant service is visible' do
      context 'when has filters' do
        context 'when an assistant_id is provided' do
          it 'returns the assistant services for the given assistant' do
            Fabricate :assistant_service
            assistant_service = Fabricate :assistant_service
            assistant = assistant_service.assistant

            filters = { assistantId: assistant.id }

            response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
            data = response['data']['assistantServices']

            expect(data.length).to eq(1)
          end
        end

        context 'when a modality is provided' do
          it 'returns the assistant services for the given modality' do
            Fabricate :assistant_service, modality: 'live'
            Fabricate :assistant_service, modality: 'closed_package'

            filters = { modality: 'closed_package' }

            response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
            data = response['data']['assistantServices']

            expect(data.length).to eq(1)
          end
        end

        context 'when a service category is provided' do
          it 'returns the assistant services for the given service category' do
            service_category = Fabricate :service_category
            Fabricate :assistant_service, service_category: service_category
            Fabricate :assistant_service, service_category: service_category

            filters = { serviceCategoryId: service_category.id }

            response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
            data = response['data']['assistantServices']

            expect(data.length).to eq(2)
          end
        end

        context 'when an online filter is provided' do
          context 'when the online is true' do
            it 'returns the assistant services for the given online filter' do
              user_online = Fabricate :user, status: :online
              user_offline = Fabricate :user, status: :offline

              assistant_online = Fabricate :assistant, user: user_online
              assistant_offline = Fabricate :assistant, user: user_offline

              Fabricate :assistant_service, assistant: assistant_online
              Fabricate :assistant_service, assistant: assistant_offline
              Fabricate :assistant_service, assistant: assistant_offline

              filters = { online: true }

              response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
              data = response['data']['assistantServices']

              expect(data.length).to eq(1)
            end
          end

          context 'when the online is false' do
            it 'returns the assistant services for the given online filter' do
              user_online = Fabricate :user, status: :online
              user_offline = Fabricate :user, status: :offline

              assistant_online = Fabricate :assistant, user: user_online
              assistant_offline = Fabricate :assistant, user: user_offline

              Fabricate :assistant_service, assistant: assistant_online
              Fabricate :assistant_service, assistant: assistant_offline
              Fabricate :assistant_service, assistant: assistant_offline

              filters = { online: false }

              response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
              data = response['data']['assistantServices']

              expect(data.length).to eq(2)
            end
          end

          context 'when the online is nil' do
            it 'returns the assistant services for the given online filter' do
              user_online = Fabricate :user, status: :online
              user_offline = Fabricate :user, status: :offline

              assistant_online = Fabricate :assistant, user: user_online
              assistant_offline = Fabricate :assistant, user: user_offline

              Fabricate :assistant_service, assistant: assistant_online
              Fabricate :assistant_service, assistant: assistant_offline
              Fabricate :assistant_service, assistant: assistant_offline

              filters = { online: nil }

              response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
              data = response['data']['assistantServices']

              expect(data.length).to eq(3)
            end
          end
        end

        context 'when are multiple filters' do
          it 'returns the assistant services for the given filters' do
            user_online = Fabricate :user, status: :online
            user_offline = Fabricate :user, status: :offline

            assistant_online = Fabricate :assistant, user: user_online
            assistant_offline = Fabricate :assistant, user: user_offline

            service_category = Fabricate :service_category
            Fabricate :assistant_service, assistant: assistant_online
            Fabricate :assistant_service, assistant: assistant_offline
            assistant_service = Fabricate :assistant_service, assistant: assistant_offline, modality: 'closed_package', service_category: service_category

            assistant = assistant_service.assistant

            filters = { online: false, assistantId: assistant.id, modality: 'closed_package', serviceCategoryId: service_category.id }

            response = ProladdoreSchema.execute(query, variables: { filters: filters }).as_json
            data = response['data']['assistantServices']

            expect(data.length).to eq(1)
          end
        end
      end

      context 'when no filters are provided' do
        it 'returns the expected fields for a user' do
          assistant_service = Fabricate :assistant_service
          assistant = assistant_service.assistant
          response = ProladdoreSchema.execute(query).as_json
          data = response['data']['assistantServices'][0]

          expect(data['id']).to eq(assistant_service.id.to_s)
          expect(data['price']).to eq(assistant_service.price)
          expect(data['assistant']['id']).to eq(assistant.id.to_s)
        end
      end
    end

    context 'when the assistant service is hidden' do
      it 'returns an empty array' do
        Fabricate :assistant_service, visible: 'hidden'
        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['assistantServices']

        expect(data.size).to eq(0)
      end
    end
  end
end
