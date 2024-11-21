# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserServices::CreateService do
  describe '#create' do
    context 'when some errors ocurrs' do
      it 'raises error' do
        Fabricate(:user, email: 'test@example.com')
        expect { described_class.instance.create(email: 'test@example.com', name: 'test', password: 'password') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when no errors ocurrs' do
      it 'creates user and wallet' do
        user = described_class.instance.create(email: 'test@example.com', name: 'test', password: 'password')
        expect(User.exists?(id: user.id)).to be(true)
        expect(user.wallet).not_to be_nil
      end
    end
  end
end
