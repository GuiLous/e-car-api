# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceCategory do
  context 'validations' do
    it 'is valid with valid attributes' do
      service_category = Fabricate(:service_category)
      expect(service_category).to be_valid
    end
  end
end
