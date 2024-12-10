# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AgoraAdapter do
  describe '#generate_channel_credentials' do
    context 'when channel name is not provided' do
      it 'returns channel credentials' do
        channel = described_class.instance.generate_channel_credentials

        expect(channel).to be_a(Hash)
        expect(channel).to have_key(:channel)
        expect(channel).to have_key(:token)
        expect(channel).to have_key(:uid)
      end
    end

    context 'when channel name is provided' do
      it 'returns channel credentials' do
        first_channel = described_class.instance.generate_channel_credentials

        second_channel = described_class.instance.generate_channel_credentials(channel_name: first_channel[:channel])

        expect(second_channel).to be_a(Hash)
        expect(second_channel).to have_key(:channel)
        expect(second_channel).to have_key(:token)
        expect(second_channel).to have_key(:uid)
        expect(second_channel[:channel]).to eq(first_channel[:channel])
      end
    end
  end
end
