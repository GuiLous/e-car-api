require 'rails_helper'

RSpec.describe User, type: :model do
  # Testa validações
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

  # Testa as associações
  context 'associations' do
    it 'has many user_services' do
      user = Fabricate(:user)
      user_service = Fabricate(:user_service, user: user)
      expect(user.user_services).to include(user_service)
    end

    it 'has many services through user_services' do
      user = Fabricate(:user)
      service = Fabricate(:service)
      Fabricate(:user_service, user: user, service: service)
      expect(user.services).to include(service)
    end
  end

  # Testa enum de roles
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

  # Testa a normalização do email
  context 'email normalization' do
    it 'normalizes email to downcase and strips leading/trailing spaces' do
      user = Fabricate(:user, email: ' Test@Example.Com ')
      expect(user.email).to eq('test@example.com')
    end
  end
end
