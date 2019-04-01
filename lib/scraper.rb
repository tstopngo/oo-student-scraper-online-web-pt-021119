require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     
     student_page = Nokogiri::HTML (open(index_url))
     students = []
     
     student_page.css(".student-card").each do |student|
       hash = {:name => student.css("div.card-text-container h4.student-name").text, :location => student.css("div.card-text-container p.student-location").text, :profile_url => student.css("a").attribute("href").value }
      students << hash
     end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    students_info = {}
    
    student_profile.css("div.social-icon-container a").each do |profile|
        url = profile.attribute("href").value
        students_info[:twitter] = url if url.include?("twitter")
        students_info[:linkedin] = url if url.include?("linkedin")
        students_info[:github] = url if url.include?("github")
        students_info[:blog] = url if profile.css("img").attribute("src").text.include?("rss")
    end
        students_info[:profile_quote] = student_profile.css("div.profile-quote").text
        students_info[:bio] = student_profile.css("div.bio-content p").text
    students_info
  end
  
  ##scrape_index_page##
  #students student.css("div.student-card")
  #student_name = student.css("div.card-text-container h4.student-name").text
  #student_location = student.css("div.card-text-container p.student-location").text
  #profile_url = student.css("a").attribute("href").value
  
  
  ##scrape_profile_page##
  #student_twitter = profile.css("div.social-icon-container ")

end

