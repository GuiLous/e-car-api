# frozen_string_literal: true

RSpec.describe Mutations::BaseMutation, type: :mutation do
  it "inherits from GraphQL::Schema::RelayClassicMutation" do
    expect(described_class < GraphQL::Schema::RelayClassicMutation).to be(true)
  end
end
