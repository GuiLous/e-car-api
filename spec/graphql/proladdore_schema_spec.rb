# frozen_string_literal: true

require 'rails_helper'

describe ProladdoreSchema do
  describe '.type_error' do
    let(:context) { {} }
    let(:error) { StandardError.new('Test error') }

    it 'calls the superclass implementation without raising an error' do
      expect { described_class.type_error(error, context) }.not_to raise_error
    end
  end

  describe '.resolve_type' do
    it 'raises GraphQL::RequiredImplementationMissingError' do
      abstract_type = instance_double(GraphQL::Schema::AbstractType)
      obj = instance_double(SomeObjectType) # Altere para o tipo real que você espera
      ctx = instance_double(GraphQL::Query::Context)
      expect { described_class.resolve_type(abstract_type, obj, ctx) }.to raise_error(GraphQL::RequiredImplementationMissingError)
    end
  end

  describe '.object_from_id' do
    it 'calls GlobalID.find with the global_id' do
      global_id = 'some_global_id'
      query_ctx = instance_double(GraphQL::Query::Context)
      expect(GlobalID).to receive(:find).with(global_id)
      described_class.object_from_id(global_id, query_ctx)
    end
  end

  describe '.id_from_object' do
    it 'calls to_gid_param on the object' do
      object = instance_double(SomeObject, to_gid_param: 'gid_value')
      type_definition = instance_double(GraphQL::ObjectType)
      query_ctx = instance_double(GraphQL::Query::Context)
      expect(object).to receive(:to_gid_param)
      described_class.id_from_object(object, type_definition, query_ctx)
    end
  end
end
