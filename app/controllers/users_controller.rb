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
    ReedScraper.new(@user.job_title, @user.location, @user.date_posted).scrape
    MonsterScraper.new(@user.job_title, @user.location, @user.date_posted).scrape
    redirect_to jobs_path
  end

  private

  def find_user
    current_user ? @user = current_user : @user = User.find(params[:id])
  end

  def set_params
    params.require(:user).permit(
      :name, :job_title, :location, :total_compensation,
      :years_experience, :education_degree, :visa_sponsor,
      :date_posted, :employment_type, :user_skills, :user_languages
    )
  end

  def education_degrees
    @education_degrees = ['High School', 'Bachelor', 'Master', 'Master of Business Administration', 'Doctor', 'Post-graduate degree' ]
  end
end
