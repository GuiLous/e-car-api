# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :graphql do
  describe 'test_field' do
    let(:query) do
      <<-GRAPHQL
        mutation {
          testField
        }
      GRAPHQL
    end

    it 'returns "Hello World"' do
      result = ProladdoreSchema.execute(query)

      expect(result['data']['testField']).to eq('Hello World')
    end
  end
end
