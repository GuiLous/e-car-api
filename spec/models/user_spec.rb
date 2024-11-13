# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = Fabricate.build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = Fabricate.build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = Fabricate.build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      Fabricate(:user, email: 'test@example.com')
      user = Fabricate.build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'is invalid without a password' do
      user = Fabricate.build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'creates a wallet' do
      user = Fabricate(:user)
      expect(user.wallet).to be_valid
    end
  end

  context 'enum roles' do
    it 'defaults to customer' do
      user = Fabricate(:user)
      expect(user.role).to eq('customer')
    end

    it 'can be an assistant' do
      user = Fabricate(:user, role: :assistant)
      expect(user.role).to eq('assistant')
    end
  end

  context 'email normalization' do
    it 'normalizes email to downcase and strips leading/trailing spaces' do
      user = Fabricate(:user, email: ' Test@Example.Com ')
      expect(user.email).to eq('test@example.com')
    end
  end
end
