# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraphqlController do
  describe 'POST #execute' do
    let(:query) { '{ sampleQuery { field } }' }
    let(:variables) { { 'var1' => 'value1' } }
    let(:operation_name) { 'SampleOperation' }

    before do
      allow(ProladdoreSchema).to receive(:execute).and_return({ 'data' => { 'field' => 'value' } })
    end

    context 'with valid parameters' do
      it 'executes the query and returns a successful JSON response' do
        post :execute, params: { query: query, variables: variables, operationName: operation_name }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.parsed_body).to eq({ 'data' => { 'field' => 'value' } })
      end
    end

    context 'with different variable formats' do
      it 'parses variables when passed as a JSON string' do
        expect(controller.send(:prepare_variables, variables.to_json)).to eq(variables)
      end

      it 'parses variables when passed as a hash' do
        expect(controller.send(:prepare_variables, variables)).to eq(variables)
      end

      it 'parses variables when passed as ActionController::Parameters' do
        params = ActionController::Parameters.new(variables)
        expect(controller.send(:prepare_variables, params)).to eq(variables)
      end

      it 'returns an empty hash when variables are nil' do
        expect(controller.send(:prepare_variables, nil)).to eq({})
      end

      it 'returns an empty hash when variables are an empty string' do
        expect(controller.send(:prepare_variables, '')).to eq({})
      end

      it 'raises an error for unexpected variable formats' do
        expect { controller.send(:prepare_variables, 123) }.to raise_error(ArgumentError, 'Unexpected parameter: 123')
      end
    end

    context 'when an error occurs' do
      before do
        allow(ProladdoreSchema).to receive(:execute).and_raise(StandardError, 'Test error')
      end

      it 'raises the error in non-development environments' do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
        expect { post :execute, params: { query: query } }.to raise_error(StandardError, 'Test error')
      end

      it 'handles the error in development environment and logs the error' do
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
        expect(controller).to receive(:handle_error_in_development).and_call_original
        post :execute, params: { query: query }

        expect(response).to have_http_status(:internal_server_error)
        json_response = response.parsed_body
        expect(json_response['errors'].first['message']).to eq('Test error')
        expect(json_response['data']).to eq({})
      end
    end
  end
end
