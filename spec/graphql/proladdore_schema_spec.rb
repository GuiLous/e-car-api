# frozen_string_literal: true

describe ProladdoreSchema do
  describe '.type_error' do
    let(:context) { {} }
    let(:error) { StandardError.new("Test error") }

    it 'calls the superclass implementation without raising an error' do
      expect { ProladdoreSchema.type_error(error, context) }.not_to raise_error
    end
  end

  describe '.resolve_type' do
    it 'raises GraphQL::RequiredImplementationMissingError' do
      abstract_type = double('abstract_type')
      obj = double('obj')
      ctx = double('ctx')
      expect { described_class.resolve_type(abstract_type, obj, ctx) }.to raise_error(GraphQL::RequiredImplementationMissingError)
    end
  end

  describe '.object_from_id' do
    it 'calls GlobalID.find with the global_id' do
      global_id = 'some_global_id'
      query_ctx = double('query_ctx')
      expect(GlobalID).to receive(:find).with(global_id)
      described_class.object_from_id(global_id, query_ctx)
    end
  end

  describe '.id_from_object' do
    it 'calls to_gid_param on the object' do
      object = double('object')
      type_definition = double('type_definition')
      query_ctx = double('query_ctx')
      expect(object).to receive(:to_gid_param)
      described_class.id_from_object(object, type_definition, query_ctx)
    end
  end
end
