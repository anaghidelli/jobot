class MonsterScraper
  def initialize(job_title, location, date_posted)
    if date_posted
      @url_monster = "https://www.monster.co.uk/jobs/search/?q=#{job_title.downcase.split.join('-')}&where=#{location.downcase.split.join('-')}&cy=uk&client=power&intcid=swoop_Hero_Search&where=london&tm=14"
    else
      @url_monster = "https://www.monster.co.uk/jobs/search/?q=#{job_title.downcase.split.join('-')}&where=#{location.downcase.split.join('-')}&cy=uk&client=power"
    end
      @html_monster = Nokogiri::HTML(open(@url_monster).read)
  end

  def scrape
    @html_monster.search('.card-content').first(35).each do |element|
    date = element.search('.meta :first-child').text
    monster_url = element.search('.title a').attribute('href')
    logo = element.search('.mux-company-logo img').attribute('src')&.value

    # begin
    # rescue URI::InvalidURIError => e
    #   puts "Rescued: #{e.inspect}"
    # end

    unless monster_url.nil?
      purl = element.search('.title a').attribute('href').value
      monster_url = URI.parse(URI.encode(purl.strip))

      monster_doc = Nokogiri::HTML(open(monster_url).read)
      company_name = monster_doc.search('.name').text.strip.capitalize
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

      find_salary = monster_doc.search('.mux-job-cards').text.split.drop(1).join

      if find_salary.include?("day")
        if find_salary.include?("-")
          salary = find_salary.split("-").first.gsub(/\D/, "") * 252
        else
          salary = find_salary.gsub(/\D/, "")
        end
      elsif find_salary.include?("annum")
        if find_salary.include?("-")
          salary = find_salary.split("-").first.gsub(/\D/, "")
        else
          salary = find_salary.gsub(/\D/, "")
        end
      else
        salary = find_salary
      end
        job = Job.create!(
          job_title: monster_doc.search('.heading :first-child').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
          description: monster_doc.search('.details-content').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
          total_compensation: salary,
          location: monster_doc.search('.value').text.split(',').first,
          date_posted: date,
          employment_type: monster_doc.search("dt:contains('Job type') + dd").text,
          url: purl,
          company: company
        )
    end
    end
  end
end
