
class RegistrationsController < Devise::RegistrationsController
  after_action :merge_users, only: [:create]

  def merge_users
    return if session[:guest_user_id].nil? || GuestUser.find_by(id: session[:guest_user_id]).nil?
    @guest_user = GuestUser.find(session[:guest_user_id])
    @user = current_user
    @user.update(
      name: @guest_user.name,
      job_title: @guest_user.job_title,
      location: @guest_user.location,
      total_compensation: @guest_user.total_compensation,
      years_experience: @guest_user.years_experience,
      education_degree: @guest_user.education_degree,
      visa_sponsor: @guest_user.visa_sponsor,
      date_posted: @guest_user.date_posted,
      employment_type: @guest_user.employment_type,
      skill_ids: @guest_user.skill_ids,
      language_ids: @guest_user.language_ids,
      industry_ids: @guest_user.industry_ids
    )
    @guest_user.destroy
  end

  protected

  def after_sign_up_path_for(resource)
    jobs_path
  end
end
