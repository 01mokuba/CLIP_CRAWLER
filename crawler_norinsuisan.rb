require 'rubygems'
require 'mechanize'

base_url = "http://"
domain = "www.maff.go.jp"
base_url = base_url + domain

archive_urls = []
for year in 6..18 do
  # puts year
  for month in 1..12 do
    archive_url = base_url + "/j/press/arc/" + String(format('%02d',year)) + String(format('%02d',month))+ ".html"
    archive_urls << archive_url
  end
end
archive_urls += [ base_url + "/j/press/index.html"]
puts archive_urls

pages = []
archive_urls.each do | archive_url |
  begin
    sleep(3)
    agent = Mechanize.new
    archive = agent.get(archive_url)

    anchor_els = archive.search("a")

    anchor_els.each do | anchor_ele |

      anchor_txt = anchor_ele.inner_text
      if anchor_txt.include?("報告書")
        page_url = anchor_ele.get_attribute(:href)
        page = {"title" => anchor_txt, "page_url" => base_url + page_url}
        pages << page
      end
    end
    puts archive_url

  rescue Mechanize::ResponseCodeError => e
    next
  end
end

pages.each do |page|
  puts page["title"] + "," + page["page_url"]
end
