# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantSubmissionsHelper do
  describe "#status_color" do
    it "returns the correct color for pending status" do
      expect(helper.status_color("pending")).to eq("warning")
    end

    it "returns the correct color for approved status" do
      expect(helper.status_color("approved")).to eq("success")
    end

    it "returns the correct color for rejected status" do
      expect(helper.status_color("rejected")).to eq("danger")
    end

    it "returns the correct color for unknown status" do
      expect(helper.status_color("unknown")).to eq("secondary")
    end
  end
end
