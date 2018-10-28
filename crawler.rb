require 'rubygems'
require 'mechanize'
require 'mysql'
require '../clip_conf.rb'

# SQL実行用の関数
def exec_sql(sql)

  # puts "execSql------"
  # puts sql 
  #DB接続
  connection = Mysql::connect("clip-rds.cshigfe65cmx.ap-northeast-1.rds.amazonaws.com",DB_USER, DB_PASS, DB_NAME)
  connection.query("set character set utf8")

  rs = connection.query(sql); 
  if rs.nil?
  	return
  end
  results = []
  rs.each do |r|
    results << r
  end
  #"execSql results------"
  #puts results
  return results
  connection.close
end

domain = "www.soumu.go.jp"
baseurl = "http://" + domain
ministry = "総務省"

#一覧ページのURLを作成・格納
archive_urls = []
for year in 15..18 do
	# puts year
	for month in 1..12 do
		if year == 18 && (month == 10 or month == 11 or month == 12)
			# puts "skip"
			next
		end
		# puts month
		archive_url = baseurl + "/menu_news/s-news/" + String(format('%02d',year)) + String(format('%02d',month))+ "m.html"
		archive_urls << archive_url
	end
end
archive_urls += [ baseurl + "/menu_news/s-news/index.html"]
puts archive_urls

#一覧ページからアンカーテキストに報告書を含むリンクを抽出
pages = []
archive_urls.each do |archive_url|
  agent = Mechanize.new
  archive = agent.get(archive_url)
  # puts archive
  anchor_els = archive.search("table a")

  anchor_els.each do | anchor_ele |

  	#アンカーテキストに報告書の文字列がなければスキップ
  	anchor_txt = anchor_ele.inner_text
  	if ! anchor_txt.include? ("報告書")
		next
	end

	page_url = anchor_ele.get_attribute(:href)

	# /を追加
	if ! page_url.start_with?("/")
		page_url = "/" + page_url 
	end

	# ドメイン名を追加
	if ! page_url.include?("soumu.go.jp")
		page_url = baseurl + page_url 
	end

	page = {"title" => anchor_txt, "page_url" => page_url}
	pages << page
  end

end

# puts pages

#詳細ページからPDFのURLを抽出・DBに格納
pages.each do | page |
	puts page["title"]
	puts page["page_url"]
	#すでにDBに登録されてればスキップ
	sql = "SELECT url FROM page";
	rs = exec_sql(sql);
	inserted_urls = []
	# pp rs
	rs.each do | arr |
		inserted_urls << arr[0]
	end

	if inserted_urls.index(page["page_url"])
		puts "already inserted"
		next
	end

	sleep(1) #攻撃を避けるため遅延
	agent = Mechanize.new
	detail_page = agent.get(page["page_url"])

	#コンテンツ内にリンク要素がなければスキップ
	anchor_els = detail_page.search("#contentsWrapper a")
	if anchor_els.empty?
		puts "no ancher"
		next
	end

	#最新のページIDを取得
	sql = "SELECT max(id) FROM page;"
	page_id = exec_sql(sql)[0][0];
	puts "got page_id"

	#アンカーテキスト要素の配列でループ
	is_page_inserted = false;
	anchor_els.each do | anchor_ele |
		#アンカーリンクにPOFが含まれなければスキップ
		anchor_link = anchor_ele.get_attribute(:href)
		if !anchor_link.end_with?("pdf")
			puts "no pdf"
			next
		end
		doc_url = anchor_link

		#初回のみページをDBに格納
		if is_page_inserted == false 
		  sql  ="INSERT INTO page(id, title, url, domain, ministry ,ins_time)"
		  sql += " VALUES(NULL, '" + page["title"] +"', '" + page["page_url"] + "', '" + domain+ "','" + ministry + "', CURRENT_TIMESTAMP);"
		  exec_sql(sql)

		  is_page_inserted = true
		  sql = "SELECT max(id) FROM page;"
		  page_id = exec_sql(sql)[0][0];
		  puts "page inseted"
		end
	
		#ドキュメントURLにドメインを追加
		if !doc_url.include?("soumu.go.jp")
			doc_url = baseurl + doc_url
		end

		#ドキュメントをDBに格納
		sql  = "INSERT INTO document(id, url, page_id, is_texted, pub_date,ins_time)"
		sql += " VALUES (null,'" + doc_url + "', " + page_id + ", 0, NULL, CURRENT_TIMESTAMP());"
		exec_sql(sql)
		puts "doc inseted"

	end 

end
