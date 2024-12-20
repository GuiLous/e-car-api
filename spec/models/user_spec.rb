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

  context 'jwt' do
    it 'generates a JWT token' do
      user = Fabricate(:user)
      expect(user.generate_jwt).to be_a(String)
    end
  end

  describe '#status' do
    context 'when user is online' do
      it 'returns online' do
        user = Fabricate(:user, status: :online)
        expect(user.status).to eq('online')
      end
    end

    context 'when user is not online' do
      it 'returns offline' do
        user = Fabricate(:user, status: :offline)
        expect(user.status).to eq('offline')
      end
    end
  end

  describe '#as_json' do
    it 'returns user as json with field status' do
      user = Fabricate(:user, status: :online)

      expect(user.as_json).to include(status: 'online')
    end
  end
end
