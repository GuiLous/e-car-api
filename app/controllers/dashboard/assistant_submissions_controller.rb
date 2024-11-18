# frozen_string_literal: true

module Dashboard
  class AssistantSubmissionsController < DashboardController
    before_action :authenticate_admin!

    def index
      @assistant_submissions = AssistantSubmission.all
    end

    def approve
      assistant_submission.approved!
      redirect_to dashboard_assistant_submissions_path
    end

    def reject
      assistant_submission.rejected!
      redirect_to dashboard_assistant_submissions_path
    end

    private

    def assistant_submission
      @assistant_submission ||= AssistantSubmission.find(params[:id])
    end
  end
end
