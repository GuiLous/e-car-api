# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::BaseEnum, type: :enum do
  it "inherits from GraphQL::Schema::Enum" do
    expect(described_class < GraphQL::Schema::Enum).to be(true)
  end
end
