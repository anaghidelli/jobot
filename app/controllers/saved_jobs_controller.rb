class SavedJobsController < ApplicationController
  def new
  end

  def create
    @job = Job.find(params[:job_id])
    saved_job = SavedJob.new(job: @job, user: current_user)
    if saved_job.save
      respond_to do |format|
        if format.js
        else
          redirect_back fallback_location: root_path
        end
      end
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
  end

end
