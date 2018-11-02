require 'rubygems'
require 'mechanize'
# require 'mysql'
# require '../clip_conf.rb'
# require './dbAccess.rb'

domain = "www.mlit.go.jp"
baseurl = "http://" + domain
# ministry = "国土交通省"

# # 一覧ページのURLを作成・格納
archive_urls = []
for year in 2012..2018 do
	for month in 1..12 do
		if year == 2018 && (month == 10 or month == 11 or month == 12)
			# puts "skip"
			next
		end
			# puts month
		archive_url = baseurl + "/report/press/houdou" + year.to_s + String(format('%02d',month)) + ".html"
		archive_urls << archive_url
	end
end
for year in 9..12 do
	for month in 1..12 do
		# puts month
		archive_url = baseurl + "/report/press/houdou" + String(format('%02d',year)) + String(format('%02d',month))+ ".html"
		archive_urls << archive_url
	end
end

# archive_urls = ["http://www.mlit.go.jp/report/press/houdou201403.html"]
puts archive_urls

#一覧ページからアンカーテキストに報告書を含むリンクを抽出
pages = []
archive_urls.each do | archive_url |
	sleep(1)
  begin
	  agent = Mechanize.new
	  archive = agent.get(archive_url)

	  anchor_els = archive.search(".section a")

	  anchor_els.each do | anchor_ele |

	  	anchor_txt = anchor_ele.inner_text
	  	if  anchor_txt.include?("報告書")
	  		if ! anchor_txt.include?("事故調査報告書")
					page_url = anchor_ele.get_attribute(:href)
					page_url = baseurl + page_url

					page = {"title" => anchor_txt, "page_url" => page_url}
					pages << page
				end
		  end
	  end

	rescue Mechanize::ResponseCodeError => e
    next
  end
end

#詳細ページからPDFのURLを抽出・DBに格納
pages.each do | page |
	# puts page["title"]
	# puts page["page_url"]

	# #すでにDBに登録されてればスキップ
	# sql = "SELECT url FROM page";
	# rs = exec_sql(sql);
	# inserted_urls = []

	# # pp rs
	# rs.each do | arr |
	# 	inserted_urls << arr[0]
	# end

	# if inserted_urls.index(page["page_url"])
	# 	puts "already inserted"
	# 	next
	# end

	sleep(1) #攻撃を避けるため遅延

	agent = Mechanize.new
	detail_page = agent.get(page["page_url"])

	#コンテンツ内にリンク要素がなければスキップ
	anchor_ele = detail_page.at("#contents .linkArrow01 a")
	anchor_link = anchor_ele.get_attribute(:href)
	if anchor_link.end_with?("pdf")

		doc_url = baseurl + anchor_link
		# puts doc_url

		pdate_tag = detail_page.at(".date")
		# puts pdate_tag
		pdate = pdate_tag.inner_text

		page["doc_url"] = doc_url
		page["pdate"] = pdate

	end

	# 	#初回のみページをDBに格納
	# 	if is_page_inserted == false
	# 	  sql  ="INSERT INTO page(id, title, url, domain, ministry ,ins_time)"
	# 	  sql += " VALUES(NULL, '" + page["title"] +"', '" + page["page_url"] + "', '" + domain+ "','" + ministry + "', CURRENT_TIMESTAMP);"
	# 	  exec_sql(sql)

	# 	  is_page_inserted = true
	# 	  sql = "SELECT max(id) FROM page;"
	# 	  page_id = exec_sql(sql)[0][0];
	# 	  puts "page inseted"
	# 	end

	# 	#ドキュメントURLにドメインを追加
	# 	if !doc_url.include?("soumu.go.jp")
	# 		doc_url = baseurl + doc_url
	# 	end

	# 	#ドキュメントをDBに格納
	# 	sql  = "INSERT INTO document(id, url, page_id, is_texted, pub_date,ins_time)"
	# 	sql += " VALUES (null,'" + doc_url + "', " + page_id + ", 0, NULL, CURRENT_TIMESTAMP());"
	# 	exec_sql(sql)
	# 	puts "doc inseted"

	# end

end

pages.each do |page|
	a = ","
	puts page["title"] + a + page["pdate"] + a + page["page_url"] + a + page["doc_url"]
end
