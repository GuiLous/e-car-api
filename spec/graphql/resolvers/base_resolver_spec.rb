# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::BaseResolver, type: :resolver do
  it "inherits from GraphQL::Schema::Resolver" do
    expect(described_class < GraphQL::Schema::Resolver).to be(true)
  end
end
