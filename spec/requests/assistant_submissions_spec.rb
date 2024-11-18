# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "AssistantSubmissions" do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  describe "GET /dashboard/assistant_submissions" do
    it "returns http success" do
      get "/dashboard/assistant_submissions"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Dashboard")
    end
  end

  describe "POST /dashboard/assistant_submissions/:id/approve" do
    let(:submission) { create(:assistant_submission) }

    it "returns http success" do
      post "/dashboard/assistant_submissions/#{submission.id}/approve"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(dashboard_assistant_submissions_path)
    end
  end

  describe "POST /dashboard/assistant_submissions/:id/reject" do
    let(:submission) { create(:assistant_submission) }

    it "returns http success" do
      post "/dashboard/assistant_submissions/#{submission.id}/reject"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(dashboard_assistant_submissions_path)
    end
  end
end
