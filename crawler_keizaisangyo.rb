require 'rubygems'
require 'mechanize'

base_url = "http://"
domain = "www.meti.go.jp"
base_url = base_url + domain

agent = Mechanize.new
page = agent.get('http://www.meti.go.jp/report/whitepaper/past_report.html')

titles = page.search("#table_main a")
pages = []
titles.each do |title|
  page_title = title.inner_text
  page_url = title.get_attribute("href")
  page = {"page_title" => page_title, "page_url" => base_url + page_url}
  pages << page
end

pages.each do |page|
  puts page["page_title"] + "," + page["page_url"]
end
