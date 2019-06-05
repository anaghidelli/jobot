class MonsterScraper
  def initialize(job_title, location)
    @url_monster = "https://www.monster.co.uk/jobs/search/?q=#{job_title.downcase.split.join('-')}&where=#{location.downcase.split.join('-')}&cy=uk&client=power"
    @html_monster = Nokogiri::HTML(open(@url_monster).read)
  end

  def scrape
    @html_monster.search('.card-content').first(25).each do |element|
    date = element.search('.meta :first-child').text
    monster_url = element.search('.title a').attribute('href')

    # begin
    # rescue URI::InvalidURIError => e
    #   puts "Rescued: #{e.inspect}"
    # end

    unless monster_url.nil?
      purl = element.search('.title a').attribute('href').value
      monster_url = URI.parse(URI.encode(purl.strip))

      monster_doc = Nokogiri::HTML(open(monster_url).read)
        job = Job.create!(
          job_title: monster_doc.search('.heading :first-child').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
          description: monster_doc.search('.details-content').text.strip.gsub( /(\r\n)|(\s)/m, " " ),
          total_compensation: monster_doc.search('.mux-job-cards').text.split.drop(1).join.gsub( /(\r\n)|(\s)/m, " " ),
          location: monster_doc.search('.value').text.split(',').first,
          date_posted: date
        )
    end
  end
end
