# frozen_string_literal: true

class AssistantSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @assistant_submissions = AssistantSubmission.pending
  end

  def approve
    AssistantSubmissionServices::AcceptService.instance.accept(
      assistant_submission_id: params[:id]
    )
    redirect_to assistant_submissions_path, notice: t("assistant_submissions.approved")
  rescue StandardError
    redirect_to assistant_submissions_path, flash: { error: t("assistant_submissions.error") }
  end

  def reject
    return redirect_to assistant_submissions_path, notice: t("assistant_submissions.rejected") if assistant_submission.update(status: :rejected)

    render json: { error: t("assistant_submissions.rejected") }, status: :unprocessable_entity
  end

  private

  def assistant_submission
    @assistant_submission ||= AssistantSubmission.find(params[:id])
  end
end
