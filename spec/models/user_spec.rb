# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to define_enum_for(:role).with_values(customer: 0, assistant: 1) }

  describe '#normalizes' do
    it 'strips and downcases email' do
      user = User.create(email: '  ExAmPlE@EmAiL.com  ', password: 'password', name: 'XPTO')
      expect(user.email).to eq('example@email.com')
    end
  end

  describe '#role' do
    it 'defaults to customer' do
      user = User.create(email: 'test@example.com', password: 'password', name: 'XPTO')
      expect(user.role).to eq('customer')
    end
  end
end
