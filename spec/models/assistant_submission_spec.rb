# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantSubmission do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 1, rejected: 2) }
  end
end
