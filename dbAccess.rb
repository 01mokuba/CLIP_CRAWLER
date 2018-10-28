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
