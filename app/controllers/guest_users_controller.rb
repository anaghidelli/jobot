class GuestUsersController < ApplicationController
  before_action :education_degrees
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @guest_user = GuestUser.new
  end

  def create
    @guest_user = GuestUser.new(guest_user_params)
    @guest_user.skill_ids = params[:guest_user][:skill_ids].reject(&:blank?)
    @guest_user.language_ids = params[:guest_user][:language_ids].reject(&:blank?)
    @guest_user.industry_ids = params[:guest_user][:industry_ids].reject(&:blank?)
    @guest_user.education_degree = params[:guest_user][:education_degree].reject(&:blank?).first
    @guest_user.employment_type = params[:guest_user][:employment_type].reject(&:blank?).first
    @guest_user.save
    reed_scrape(@guest_user.job_title, @guest_user.location)
    session[:guest_user_id] = @guest_user.id
    redirect_to new_user_registration_path
  end

  private

  def reed_scrape(job_title, location)
    puts "Scraping jobs from reed.co.uk"
    @url = "https://www.reed.co.uk/jobs/#{job_title.downcase.split.join('-')}-jobs-in-#{location.downcase.split.join('-')}"
    @html_doc = Nokogiri::HTML(open(@url).read)
    @html_doc.search(".job-result").first(10).each do |element|
      compensation = element.search('.salary').text.strip
      location = element.search('.location').text.split.slice(2)
      date = element.search('.posted-by').text.strip
      show_url = element.search(".title a").attribute('href').value
      full_url = "https://www.reed.co.uk#{show_url}"
      html_show = Nokogiri::HTML(open(full_url).read)
      logo = html_show.search('.logo-wrap meta').attr('content')&.value
      company_url = html_show.search('.logo-wrap').attr('href')&.value
        if company_url.match(/company-profile/)
            company_show = Nokogiri::HTML(open("https://www.reed.co.uk#{company_url}").read)
            company_industry = company_show.search('.information__item')
            industry_name = company_industry.find { |e| e.search('.information__title').text.strip == "Sector" }
            industry_name = industry_name.search('.information__description').text.strip
            if Industry.find_by(name: industry_name)
              industry = Industry.find_by(name: industry_name)
            else
              industry = Industry.new(name: industry_name)
              industry.save
            end
        end
        company_name = html_show.search('.posted span').text.strip.capitalize
        "company: #{company_name}, logo: #{logo}"
        company = Company.find_by(name: company_name)
        unless company
          begin
          company = Company.new(name: company_name)
          company.remote_logo_url = logo.nil? ? './app/assets/images/default-robot.png' : logo
          company.save
          rescue => e
            company.remote_logo_url = './app/assets/images/default-robot.png'
            company.save
          end
        end
        if CompanyIndustry.where(company: company, industry: industry).empty? && industry
          CompanyIndustry.create(company: company, industry: industry)
        end
        company
        job = Job.create!(
          job_title: html_show.search(".col-xs-12 h1").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
          description: html_show.search(".description").text.strip,
          total_compensation: html_show.search(".salary").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
          location: html_show.search('.location span[data-qa="localityLbl"]').text.strip.gsub( /(\r\n)|(\s)/m, "" ),
          employment_type: html_show.search(".time").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
          date_posted: Date.parse(html_show.search('.posted meta').attr('content')&.value),
          company: company,
          url: full_url
        )
      end
  end

  def education_degrees
    @education_degrees = ['High School Diploma', 'Master of Arts (M.A.)', 'Master of Science (M.S.)', 'Master of Business Administration (MBA)', 'Master of Fine Arts (MFA)', 'Bachelor of Arts (B.A.)', 'Bachelor of Science (B.S.)', 'Bachelor of Fine Arts (BFA)', 'Bachelor of Applied Science (BAS)', 'Associate of Arts (A.A.)', 'Associate of Science (A.S.)', 'Associate of Applied Science (AAS)', 'Doctor of Philosophy (Ph.D.)', 'Juris Doctor (J.D.)', 'Doctor of Medicine (M.D.)', 'Doctor of Dental Surgery (DDS)]']
  end

  def guest_user_params
    params.require(:guest_user).permit(:name, :job_title, :location, :total_compensation, :years_experience, :visa_sponsor, :education_degree, :employment_type, :date_posted)
  end
end
