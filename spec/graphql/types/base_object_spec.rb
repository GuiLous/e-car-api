# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::BaseObject, type: :object do
  it 'inherits from GraphQL::Schema::Object' do
    expect(described_class < GraphQL::Schema::Object).to be(true)
  end
end
