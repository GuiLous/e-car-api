# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService do
  context 'validations' do
    it 'is valid with valid attributes' do
      user_service = Fabricate.build(:user_service)
      expect(user_service).to be_valid
    end

    it 'is invalid without a user' do
      user_service = Fabricate.build(:user_service, user: nil)
      expect(user_service).not_to be_valid
      expect(user_service.errors[:user]).to include('must exist')
    end

    it 'is invalid without a service' do
      user_service = Fabricate.build(:user_service, service: nil)
      expect(user_service).not_to be_valid
      expect(user_service.errors[:service]).to include('must exist')
    end

    it 'has a default price of 0' do
      user_service = Fabricate(:user_service)
      expect(user_service.price).to eq(0)
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      user_service = Fabricate.create(:user_service)
      expect(user_service.user).to be_present
    end

    it 'belongs to a service' do
      user_service = Fabricate.create(:user_service)
      expect(user_service.service).to be_present
    end
  end
end
