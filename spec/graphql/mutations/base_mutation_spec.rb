# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::BaseMutation, type: :mutation do
  it 'inherits from GraphQL::Schema::Mutation' do
    expect(described_class < GraphQL::Schema::Mutation).to be(true)
  end
end
