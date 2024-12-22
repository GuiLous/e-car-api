# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserServices::CreateService do
  describe '#create' do
    context 'when some errors occurs' do
      it 'raises error' do
        Fabricate(:user, email: 'test@example.com')
        expect { described_class.instance.create(email: 'test@example.com', first_name: 'test', password: 'password') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when no errors occurs' do
      it 'creates user and wallet' do
        user = described_class.instance.create(email: 'test@example.com', first_name: 'test', last_name: 'test', phone: 'test', password: 'password')
        expect(User.exists?(id: user.id)).to be(true)
      end
    end
  end
end
