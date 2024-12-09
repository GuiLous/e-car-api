# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionService do
  context 'associations' do
    describe "enums" do
      it { is_expected.to define_enum_for(:status).with_values(created: 0, in_progress: 1, done: 2) }
    end

    it 'belongs to a hired service' do
      session_service = Fabricate(:session_service)
      expect(session_service.hired_service).to be_present
    end
  end
end
