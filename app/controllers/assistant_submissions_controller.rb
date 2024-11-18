# frozen_string_literal: true

class AssistantSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @assistant_submissions = AssistantSubmission.pending
  end

  def approve
    if assistant_submission.update(status: :approved)
      redirect_to assistant_submissions_path
    else
      render json: { error: "Error approving the submission" }, status: :unprocessable_entity
    end
  end

  def reject
    if assistant_submission.update(status: :rejected)
      redirect_to assistant_submissions_path
    else
      render json: { error: "Error rejecting the submission" }, status: :unprocessable_entity
    end
  end

  private

  def assistant_submission
    @assistant_submission ||= AssistantSubmission.find(params[:id])
  end
end
