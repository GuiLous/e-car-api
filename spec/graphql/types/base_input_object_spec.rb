# frozen_string_literal: true

RSpec.describe Types::BaseInputObject, type: :input_object do
  it "inherits from GraphQL::Schema::InputObject" do
    expect(described_class < GraphQL::Schema::InputObject).to be(true)
  end
end
