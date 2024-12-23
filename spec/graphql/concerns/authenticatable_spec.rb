# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authenticatable do
  let(:dummy_class) do
    Class.new do
      include Authenticatable
      attr_accessor :context
    end
  end

  let(:instance) { dummy_class.new }

  describe '#authenticate_user!' do
    context 'when current_user exists in context' do
      before do
        instance.context = { current_user: instance_double(User) }
      end

      it 'does not raise an error' do
        expect { instance.authenticate_user! }.not_to raise_error
      end
    end

    context 'when current_user does not exist in context' do
      before do
        instance.context = { current_user: nil }
      end

      it 'raises an unauthorized error' do
        expect { instance.authenticate_user! }
          .to raise_error(Exceptions::UnauthorizedError, 'UNAUTHORIZED')
      end
    end
  end
end
