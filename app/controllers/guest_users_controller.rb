class GuestUsersController < ApplicationController
  before_action :education_degrees, :employment_types
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @guest_user = GuestUser.new
  end

  def create
    @guest_user = GuestUser.new(guest_user_params)
    @guest_user.skill_ids = params[:guest_user][:skill_ids].reject(&:blank?)
    @guest_user.language_ids = params[:guest_user][:language_ids].reject(&:blank?)
    @guest_user.industry_ids = params[:guest_user][:industry_ids].reject(&:blank?)
    @guest_user.education_degree = params[:guest_user][:education_degree]
    @guest_user.employment_type = params[:guest_user][:employment_type]
    @guest_user.save
    reed_scrape(@guest_user.job_title, @guest_user.location, @guest_user.date_posted)
    monster_scrape(@guest_user.job_title, @guest_user.location, @guest_user.date_posted).scrape
    session[:guest_user_id] = @guest_user.id
    redirect_to new_user_registration_path
  end

  private

  def reed_scrape(job_title, location, date_posted)
    puts "Scraping jobs from reed.co.uk"
    ReedScraper.new(job_title, location, date_posted).scrape
  end

  def monster_scrape(job_title, location, date_posted)
    MonsterScraper.new(job_title, location, date_posted).scrape

  end

  def education_degrees
    @education_degrees = ['High School Diploma', 'Master of Arts (M.A.)', 'Master of Science (M.S.)', 'Master of Business Administration (MBA)', 'Master of Fine Arts (MFA)', 'Bachelor of Arts (B.A.)', 'Bachelor of Science (B.S.)', 'Bachelor of Fine Arts (BFA)', 'Bachelor of Applied Science (BAS)', 'Associate of Arts (A.A.)', 'Associate of Science (A.S.)', 'Associate of Applied Science (AAS)', 'Doctor of Philosophy (Ph.D.)', 'Juris Doctor (J.D.)', 'Doctor of Medicine (M.D.)', 'Doctor of Dental Surgery (DDS)]']
  end

  def employment_types
    @employment_types = ['Full-time', 'Part-time', 'Internship', 'Any']
  end

  def guest_user_params
    params.require(:guest_user).permit(:name, :job_title, :location, :total_compensation, :years_experience, :visa_sponsor, :date_posted, :education_degree, :employment_type)
  end
end
