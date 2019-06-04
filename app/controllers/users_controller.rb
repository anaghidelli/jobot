class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :education_degrees, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    @skillz = params[:user][:skill_ids].map { |skill|  Skill.find(skill) if skill != "" }
    @user.skills = @skillz.compact
    @languagez = params[:user][:language_ids].map { |language| Language.find(language) if language != "" }
    @user.languages = @languagez.compact
    # @degreez = params[:user][:education_degree] - [""]
    # @user.education_degree = @degreez
    @user.update(set_params)
    redirect_to jobs_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def set_params
    params.require(:user).permit(
      :name, :job_title, :location, :total_compensation,
      :years_experience, :education_degree, :visa_sponsor,
      :date_posted, :employment_type, :user_skills, :user_languages
    )
  end

  def education_degrees
    @education_degrees = ['High School Diploma', 'Master of Arts (M.A.)', 'Master of Science (M.S.)', 'Master of Business Administration (MBA)', 'Master of Fine Arts (MFA)', 'Bachelor of Arts (B.A.)', 'Bachelor of Science (B.S.)', 'Bachelor of Fine Arts (BFA)', 'Bachelor of Applied Science (BAS)', 'Associate of Arts (A.A.)', 'Associate of Science (A.S.)', 'Associate of Applied Science (AAS)', 'Doctor of Philosophy (Ph.D.)', 'Juris Doctor (J.D.)', 'Doctor of Medicine (M.D.)', 'Doctor of Dental Surgery (DDS)]']
  end
end
