# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase do
  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, paid: 1, cancelled: 2) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
