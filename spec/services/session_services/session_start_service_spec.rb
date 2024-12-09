# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionServices::SessionStartService, type: :service do
  describe '#start' do
    subject { described_class.instance }

    context "when assistant service modality its not live" do
      it 'raises HiredServiceItsNotLive exception' do
        assistant_service = Fabricate :assistant_service, modality: :closed_package
        hired_service = Fabricate :hired_service, assistant_service: assistant_service

        expect {
          subject.start(hired_service_id: hired_service.id, current_user: hired_service.user)
        }.to raise_error(Exceptions::HiredServiceItsNotLive, 'SERVICE_NOT_LIVE')
      end
    end

    context "when session service its nil" do
      it 'raises SessionServiceNotFound exception' do
        hired_service = Fabricate :hired_service, session_service: nil

        expect {
          subject.start(hired_service_id: hired_service.id, current_user: hired_service.assistant_service.assistant.user)
        }.to raise_error(Exceptions::SessionServiceNotFound, "NOT_FOUND")
      end
    end

    context "when session is in progress" do
      it 'raises SessionServiceInProgress exception' do
        hired_service = Fabricate :hired_service
        Fabricate :session_service, hired_service: hired_service, status: :in_progress

        expect {
          subject.start(hired_service_id: hired_service.id, current_user: hired_service.assistant_service.assistant.user)
        }.to raise_error(Exceptions::SessionServiceInProgress, "IN_PROGRESS")
      end
    end

    context "when consumer enter on session" do
      it "should create session" do
        hired_service = Fabricate :hired_service
        session_service = subject.start(hired_service_id: hired_service.id, current_user: hired_service.user)

        expect(session_service.status).to eq('created')
        expect(session_service.consumer_started_at).to be_present
      end
    end

    context "when assistant enter on session" do
      it "should start session" do
        hired_service = Fabricate :hired_service
        Fabricate :session_service, hired_service: hired_service, assistant_started_at: nil, status: :created

        response = subject.start(hired_service_id: hired_service.id, current_user: hired_service.assistant_service.assistant.user)

        expect(response.status).to eq('in_progress')
        expect(response.assistant_started_at).to be_present
      end
    end
  end
end
