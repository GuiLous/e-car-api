# frozen_string_literal: true

RSpec.describe Types::BaseScalar, type: :scalar do
  it "inherits from GraphQL::Schema::Scalar" do
    expect(described_class < GraphQL::Schema::Scalar).to be(true)
  end
end
