# frozen_string_literal: true

class AssistantSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @assistant_submissions = AssistantSubmission.pending
  end

  def approve
    assistant_submission.approved!
    redirect_to assistant_submissions_path
  end

  def reject
    assistant_submission.rejected!
    redirect_to assistant_submissions_path
  end

  private

  def assistant_submission
    @assistant_submission ||= AssistantSubmission.find(params[:id])
  end
end
