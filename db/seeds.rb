require "open-uri"
require "nokogiri"

Job.destroy_all
Company.destroy_all


# High School Diploma
# Master of Arts (M.A.)
# Master of Science (M.S.)
# Master of Business Administration (MBA)
# Master of Fine Arts (MFA)
# Bachelor of Arts (B.A.)
# Bachelor of Science (B.S.)
# Bachelor of Fine Arts (BFA)
# Bachelor of Applied Science (BAS)
# Associate of Arts (A.A.)
# Associate of Science (A.S.)
# Associate of Applied Science (AAS)
# Doctor of Philosophy (Ph.D.)
# Juris Doctor (J.D.)
# Doctor of Medicine (M.D.)
# Doctor of Dental Surgery (DDS)



# Marketing Technologist
# SEO Consultant
# Web Analytics Developer
# Digital Marketing Manager
# Social Media Manager
# Growth Hacker
# Content Manager
# Content Strategist
# Information Architect
# UX Designer
# UI Designer
# Accessibility Specialist
# Interaction Designer
# Front-End Designer
# Front-End Developer
# Mobile Developer
# Full-Stack Developer
# Software Developers
# WordPress Developer
# Frameworks Specialist
# Ruby on Rails Developer
# Python Developer
# Business Systems Analyst
# Systems Engineer
# Systems Administrator
# Database Administrator
# Data Architect
# Data Modeler
# Data Analyst
# Data Scientist

Language.destroy_all

language = Language.create(name: "Chinese")
language = Language.create(name: "Mandarin")
language = Language.create(name: "English")
language = Language.create(name: "Hindi")
language = Language.create(name: "Arabic")
language = Language.create(name: "Portuguese")
language = Language.create(name: "Bengali")
language = Language.create(name: "Russian")
language = Language.create(name: "Japanese")
language = Language.create(name: "Lahnda")
language = Language.create(name: "Italian")
language = Language.create(name: "German")
language = Language.create(name: "Korean")
language = Language.create(name: "French")
language = Language.create(name: "Turkish")


Skill.destroy_all

skill = Skill.create(name: "Javascript")
skill = Skill.create(name: "Python")
skill = Skill.create(name: "Java")
skill = Skill.create(name: "C++")
skill = Skill.create(name: "Swift")
skill = Skill.create(name: "TypeScript")
skill = Skill.create(name: "Go Programming Language")
skill = Skill.create(name: "SQL")
skill = Skill.create(name: "Ruby on Rails")
skill = Skill.create(name: "R Programming Language")
skill = Skill.create(name: "PHP")
skill = Skill.create(name: "Perl")
skill = Skill.create(name: "Kotlin")
skill = Skill.create(name: "C#")
skill = Skill.create(name: "Rust")
skill = Skill.create(name: "Scheme")
skill = Skill.create(name: "Erlang")
skill = Skill.create(name: "Scala")
skill = Skill.create(name: "Elixir")
skill = Skill.create(name: "Haskell")
skill = Skill.create(name: "HTML")
skill = Skill.create(name: "CSS")


# puts "Scraping jobs from reed.co.uk"

# @url = "https://www.reed.co.uk/jobs/web-developer-jobs-in-london"
# @html_doc = Nokogiri::HTML(open(@url).read)
# @html_doc.search(".job-result").first(25).each do |element|
#   compensation = element.search('.salary').text.strip
#   location = element.search('.location').text.split.slice(2)
#   date = element.search('.posted-by').text.strip
#   show_url = element.search(".title a").attribute('href').value
#   full_url = "https://www.reed.co.uk#{show_url}"
#   html_show = Nokogiri::HTML(open(full_url).read)
#   logo = html_show.search('.logo-wrap meta').attr('content')&.value
#   company_url = html_show.search('.logo-wrap').attr('href')&.value
#     if company_url.match(/company-profile/)
#         company_show = Nokogiri::HTML(open("https://www.reed.co.uk#{company_url}").read)
#         company_industry = company_show.search('.information__item')
#         industry_name = company_industry.find { |e| e.search('.information__title').text.strip == "Sector" }
#         industry_name = industry_name.search('.information__description').text.strip
#         if Industry.find_by(name: industry_name)
#           industry = Industry.find_by(name: industry_name)
#         else
#           industry = Industry.new(name: industry_name)
#           industry.save
#         end
#     end
#     company_name = html_show.search('.posted span').text.strip.capitalize
#     "company: #{company_name}, logo: #{logo}"
#     if Company.find_by(name: company_name)
#       company = Company.find_by(name: company_name)
#       else
#         company = Company.new(name: company_name)
#         company.remote_logo_url = logo.nil? ? './app/assets/images/default-robot.png' : logo
#         company.save
#     end
#     if CompanyIndustry.where(company: company, industry: industry).empty? && industry
#       CompanyIndustry.create(company: company, industry: industry)
#     end
#     company
#     job = Job.create!(
#       job_title: html_show.search(".col-xs-12 h1").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
#       description: html_show.search(".description").text.strip,
#       total_compensation: html_show.search(".salary").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
#       location: html_show.search('.location span[data-qa="localityLbl"]').text.strip.gsub( /(\r\n)|(\s)/m, "" ),
#       employment_type: html_show.search(".time").text.strip.gsub( /(\r\n)|(\s)/m, "" ),
#       date_posted: Date.parse(html_show.search('.posted meta').attr('content')&.value),
#       company: company,
#       url: full_url
#     )
#   end

# puts "Scraping jobs from indeed.co.uk"
#     url = "https://www.indeed.co.uk/Web-Developer-jobs-in-London"

#   html_doc = Nokogiri::HTML(open(url).read)
#   html_doc.search(".jobsearch-SerpJobCard").first(25).each do |element|
#     show_url = element.search(".title a").attribute('href').value
#     full_url = "https://www.indeed.co.uk#{show_url}"
#     html_show = Nokogiri::HTML(open(full_url).read)
#     job = Job.create!(

#       job_title: html_show.search(".jobsearch-JobInfoHeader-title").text.strip,
#       location: html_show.search(".jobsearch-InlineCompanyRating :nth-child(3)").text.strip,
#       date_posted: html_show.search(".jobsearch-JobMetadataFooter").text.split('-').first,     # total_compensation: html_show.search("#salary.no-wrap").text.strip,
#       description: html_show.search('.jobsearch-jobDescriptionText').text.strip

#     )
#   end

# puts "Scraping monster jobs!"

# @url_monster = "https://www.monster.co.uk/jobs/search/?q=web-developer&where=london&cy=uk&client=power"
# @html_monster = Nokogiri::HTML(open(@url_monster).read)
# @html_monster.search('.card-content').first(25).each do |element|
#   date = element.search('.meta :first-child').text
#   monster_url = element.search('.title a').attribute('href')

#   # begin
#   # rescue URI::InvalidURIError => e
#   #   puts "Rescued: #{e.inspect}"
#   # end

#   unless monster_url.nil?
#     purl = element.search('.title a').attribute('href').value
#     monster_url = URI.parse(URI.encode(purl.strip))

#     monster_doc = Nokogiri::HTML(open(monster_url).read)
#       job = Job.create!(
#         job_title: monster_doc.search('.heading :first-child').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
#         description: monster_doc.search('.details-content').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
#         total_compensation: monster_doc.search('.mux-job-cards').text.split.drop(1).join.gsub( /(\r\n)|(\s)/m, " " ),
#         location: monster_doc.search('.value').text.split(',').first,
#         date_posted: date
#       )
#   end
