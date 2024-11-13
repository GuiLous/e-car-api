# frozen_string_literal: true

module Mutations
  module HiredServiceMutations
    class FinishHiredService < BaseMutation
      field :message, String, null: false

      argument :hired_service_id, ID, required: true

      def resolve(hired_service_id:)
        HiredServices::UpdateToAnalizingService.instance.update_to_analizing(hired_service_id: hired_service_id)
      end
    end
  end
end
