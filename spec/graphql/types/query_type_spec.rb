# frozen_string_literal: true

RSpec.describe Types::QueryType do
  describe 'Assistants' do
    let(:query) do
      <<~GQL
        query {
          assistants {
            id
          }
        }
      GQL
    end

    context 'when does not exists users with assistant role' do
      it 'returns a empty array' do
          Fabricate :user, role: :customer
          response = ProladdoreSchema.execute(query).as_json
          data = response['data']['assistants']
          expect(data.size).to eq(0)
      end
    end

    context 'when exists users with assistant role' do
      it 'returns an arrays of assistants' do
        Fabricate :user, role: :assistant
        response = ProladdoreSchema.execute(query).as_json
        data = response['data']['assistants']
        expect(data.size).to eq(1)
      end
    end
  end
end
