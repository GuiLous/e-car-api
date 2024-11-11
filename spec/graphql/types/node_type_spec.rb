# frozen_string_literal: true

require 'rails_helper'

describe Types::NodeType, type: :type do
  describe '.included' do
    it 'includes the GraphQL::Types::Relay::NodeBehaviors module' do
      expect(described_class.included_modules).to include(GraphQL::Types::Relay::NodeBehaviors)
    end

    it 'includes the Types::BaseInterface module' do
      expect(described_class.included_modules).to include(Types::BaseInterface)
    end
  end
end
