# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantSubmissionServices::CreatorService do
  describe '#create' do
    context 'when user have pending submission' do
      it 'raise error' do
        user = Fabricate(:user)

        user.assistant_submissions.create(description: 'xpto', status: :pending)

        service = Fabricate(:service)
        service_category = Fabricate(:service_category)

        expect do
          described_class.instance.create(
            user: user,
            description: 'xpto',
            modality: 'live',
            price: 100,
            service_id: service.id,
            service_category_id: service_category.id
          )
        end.to raise_error(Exceptions::UserHasPendingSubmissionError)
      end
    end

    context 'when user does not have pending submission' do
      context "when user is an assistant" do
        it 'raise error' do
          assistant = Fabricate(:assistant)

          user = assistant.user

          service = Fabricate(:service)
          service_category = Fabricate(:service_category)

          expect do
            described_class.instance.create(
              user: user,
              description: 'xpto',
              modality: 'live',
              price: 100,
              service_id: service.id,
              service_category_id: service_category.id
            )
          end.to raise_error(Exceptions::UserIsAlreadyAnAssistantError)
        end
      end

      context "when user is not an assistant" do
        it 'create assistant model' do
          user = Fabricate(:user)
          service = Fabricate(:service)
          service_category = Fabricate(:service_category)

          described_class.instance.create(
            user: user,
            description: 'xpto',
            modality: 'live',
            price: 100,
            service_id: service.id,
            service_category_id: service_category.id
          )

          expect(user.assistant_submissions.last.status).to eq('pending')
        end
      end
    end
  end
end
