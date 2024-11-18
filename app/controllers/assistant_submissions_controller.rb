# frozen_string_literal: true

class AssistantSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @assistant_submissions = AssistantSubmission.pending
  end

  def approve
    return redirect_to assistant_submissions_path if assistant_submission.update(status: :approved)

    render json: { error: "Error approving the submission" }, status: :unprocessable_entity
  end

  def reject
    return redirect_to assistant_submissions_path if assistant_submission.update(status: :rejected)

    render json: { error: "Error rejecting the submission" }, status: :unprocessable_entity
  end

  private

  def assistant_submission
    @assistant_submission ||= AssistantSubmission.find(params[:id])
  end
end
