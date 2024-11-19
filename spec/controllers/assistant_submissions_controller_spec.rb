# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantSubmissionsController do
  let(:admin) { Fabricate(:admin) }
  let(:pending_submission) { Fabricate(:assistant_submission, status: :pending) }
  let(:approved_submission) { Fabricate(:assistant_submission, status: :approved) }
  let(:rejected_submission) { Fabricate(:assistant_submission, status: :rejected) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it "returns only pending assistant submissions" do
      pending_submission
      approved_submission
      rejected_submission

      get :index
      expect(assigns(:assistant_submissions)).to eq([ pending_submission ])
    end
  end

  describe "POST #approve" do
    it "updates the status of the submission to approved" do
      post :approve, params: { id: pending_submission.id }
      expect(pending_submission.reload.status).to eq("approved")
    end

    it "returns error message when approval fails" do
      mock_service = instance_double(AssistantSubmissionServices::AcceptorService)
      allow(AssistantSubmissionServices::AcceptorService).to receive(:instance).and_return(mock_service)
      allow(mock_service).to receive(:accept).and_raise(StandardError.new(I18n.t("assistant_submissions.error")))

      post :approve, params: { id: pending_submission.id }
      expect(response).to redirect_to(assistant_submissions_path)
      expect(flash[:error]).to eq(I18n.t("assistant_submissions.error"))
    end
  end

  describe "POST #reject" do
    it "updates the status of the submission to rejected" do
      post :reject, params: { id: pending_submission.id }
      expect(pending_submission.reload.status).to eq("rejected")
    end

    it "returns error message when rejection fails" do
      submission = pending_submission
      allow(AssistantSubmission).to receive(:find).and_return(submission)
      allow(submission).to receive(:update).and_return(false)

      post :reject, params: { id: submission.id, format: :json }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["error"]).to eq(I18n.t("assistant_submissions.rejected"))
    end
  end
end
