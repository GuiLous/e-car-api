# frozen_string_literal: true

RSpec.describe Types::BaseUnion, type: :union do
  it "inherits from GraphQL::Schema::Union" do
    expect(described_class < GraphQL::Schema::Union).to be(true)
  end
end
