# frozen_string_literal: true

RSpec.describe Types::BaseInterface, type: :interface do
  it "includes GraphQL::Schema::Interface" do
    expect(described_class).to include(GraphQL::Schema::Interface)
  end
end
