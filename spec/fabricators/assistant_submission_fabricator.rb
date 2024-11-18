# frozen_string_literal: true

Fabricator(:assistant_submission) do
  user { Fabricate(:user) }
  status { AssistantSubmission.statuses.keys.sample }
end
