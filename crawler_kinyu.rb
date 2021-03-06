require 'rubygems'
require 'mechanize'
# require 'mysql'
# require '../clip_conf.rb'
# require './dbAccess.rb'

domain = "www.fsa.go.jp"
baseurl = "https://" + domain
ministry = "金融庁"

#一覧ページのURLを作成・格納
#何故かH15・H16だけURLの形式が異なるので注意
#H12・H13
archive_urls = ["https://www.fsa.go.jp/news/27_news_menu.html"]

# archive_urls = ["https://www.fsa.go.jp/news/","https://www.fsa.go.jp/news/29_news_menu.html","https://www.fsa.go.jp/news/28_news_menu.html","https://www.fsa.go.jp/news/27_news_menu.html","https://www.fsa.go.jp/news/26_news_menu.html","https://www.fsa.go.jp/news/25_news_menu.html","https://www.fsa.go.jp/news/24_news_menu.html","https://www.fsa.go.jp/news/23_news_menu.html","https://www.fsa.go.jp/news/22_news_menu.html","https://www.fsa.go.jp/news/21_news_menu.html","https://www.fsa.go.jp/news/20_news_menu.html","https://www.fsa.go.jp/news/19_news_menu.html","https://www.fsa.go.jp/news/18_news_menu.html","https://www.fsa.go.jp/news/17_news_menu.html","https://www.fsa.go.jp/news/newsj/16/news_menu.html","https://www.fsa.go.jp/news/newsj/15/news_menu.html","https://www.fsa.go.jp/news/14_news_menu.html","https://www.fsa.go.jp/news/13_news_menu.html"]
puts archive_urls

#一覧ページからアンカーテキストに報告書を含むリンクを抽出
pages = []
archive_urls.each do |archive_url|
  agent = Mechanize.new
  archive = agent.get(archive_url)
  # puts archive
  anchor_els = archive.search(".inner a")

  anchor_els.each do | anchor_ele |

  	#アンカーテキストに報告書の文字列がなければスキップ
  	anchor_txt = anchor_ele.inner_text
  	if ! anchor_txt.include?("報告書")
			next
		end

		page_url = anchor_ele.get_attribute(:href)

		#委員会等の報告書のみを保管（その他は行政sy
		if page_url.include?("singi")
			page = {"title" => anchor_txt, "page_url" => page_url}
			pages << page
		end


  # 	#URLにsingiが含まれなければスキップ
		# page_url = anchor_ele.get_attribute(:href)
		# if ! page_url.include?("singi")
		# 	next
		# end

		# #アンカーテキストに報告書が含まれるもののみを保管
  # 	anchor_txt = anchor_ele.inner_text
  # 	if anchor_txt.include?("報告書")
		# 	page_url = baseurl + page_url
		# 	page = {"title" => anchor_txt, "page_url" => page_url}
		# 	pages << page
		# end

	end

end

puts pages



# #詳細ページからPDFのURLを抽出・DBに格納
# pages.each do | page |
# 	puts page["title"]
# 	puts page["page_url"]

# 	# #すでにDBに登録されてればスキップ
# 	# sql = "SELECT url FROM page";
# 	# rs = exec_sql(sql);
# 	# inserted_urls = []
# 	# # pp rs
# 	# rs.each do | arr |
# 	# 	inserted_urls << arr[0]
# 	# end

# 	# if inserted_urls.index(page["page_url"])
# 	# 	puts "already inserted"
# 	# 	next
# 	# end

# 	sleep(1) #攻撃を避けるため遅延
# 	agent = Mechanize.new
# 	detail_page = agent.get(page["page_url"])

# 	#コンテンツ内にリンク要素がなければスキップ
# 	anchor_els = detail_page.search("#contentsWrapper a")
# 	if anchor_els.empty?
# 		puts "no ancher"
# 		next
# 	end

# 	# #最新のページIDを取得
# 	# sql = "SELECT max(id) FROM page;"
# 	# page_id = exec_sql(sql)[0][0];
# 	# puts "got page_id"

# 	#アンカーテキスト要素の配列でループ
# 	is_page_inserted = false;
# 	anchor_els.each do | anchor_ele |
# 		#アンカーリンクにPOFが含まれなければスキップ
# 		anchor_link = anchor_ele.get_attribute(:href)
# 		if !anchor_link.end_with?("pdf")
# 			puts "no pdf"
# 			next
# 		end
# 		doc_url = anchor_link

# 		# #初回のみページをDBに格納
# 		# if is_page_inserted == false
# 		#   sql  ="INSERT INTO page(id, title, url, domain, ministry ,ins_time)"
# 		#   sql += " VALUES(NULL, '" + page["title"] +"', '" + page["page_url"] + "', '" + domain+ "','" + ministry + "', CURRENT_TIMESTAMP);"
# 		#   exec_sql(sql)

# 		#   is_page_inserted = true
# 		#   sql = "SELECT max(id) FROM page;"
# 		#   page_id = exec_sql(sql)[0][0];
# 		#   puts "page inseted"
# 		# end

# 		#ドキュメントURLにドメインを追加
# 		if !doc_url.include?("soumu.go.jp")
# 			doc_url = baseurl + doc_url
# 		end

# 		# #ドキュメントをDBに格納
# 		# sql  = "INSERT INTO document(id, url, page_id, is_texted, pub_date,ins_time)"
# 		# sql += " VALUES (null,'" + doc_url + "', " + page_id + ", 0, NULL, CURRENT_TIMESTAMP());"
# 		# exec_sql(sql)
# 		# puts "doc inseted"

# 	end

# 	#データベースを操作できないので代わりに配列に追加
# 	page.store("doc_url", doc_url)

# end

# puts pages
