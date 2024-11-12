# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HiredService do
  context 'validations' do
    it 'is valid with valid attributes' do
      hired_service = Fabricate.build(:hired_service)
      expect(hired_service).to be_valid
    end
  end
end
