# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "AssistantSubmissions" do
  let(:admin) { Fabricate(:admin) }

  before do
    sign_in admin
  end

  describe "GET /assistant_submissions" do
    it "returns http success" do
      get "/assistant_submissions"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Dashboard")
    end
  end

  describe "POST /assistant_submissions/:id/approve" do
    let(:submission) { Fabricate(:assistant_submission) }

    it "returns http success" do
      post "/assistant_submissions/#{submission.id}/approve"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(assistant_submissions_path)
    end
  end

  describe "POST /assistant_submissions/:id/reject" do
    let(:submission) { Fabricate(:assistant_submission) }

    it "returns http success" do
      post "/assistant_submissions/#{submission.id}/reject"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(assistant_submissions_path)
    end
  end
end
