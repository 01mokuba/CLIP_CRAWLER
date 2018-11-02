require 'rubygems'
require 'mechanize'

base_url = "https://"
domain = "www.env.go.jp"
base_url = base_url + domain

archive_urls = ["https://www.env.go.jp/press/201001/03-week.html","https://www.env.go.jp/press/201001/10-week.html","https://www.env.go.jp/press/201001/17-week.html","https://www.env.go.jp/press/201001/24-week.html","https://www.env.go.jp/press/201001/31-week.html","https://www.env.go.jp/press/201002/07-week.html","https://www.env.go.jp/press/201002/14-week.html","https://www.env.go.jp/press/201002/21-week.html","https://www.env.go.jp/press/201002/28-week.html","https://www.env.go.jp/press/201003/07-week.html","https://www.env.go.jp/press/201003/14-week.html","https://www.env.go.jp/press/201003/21-week.html","https://www.env.go.jp/press/201003/28-week.html","https://www.env.go.jp/press/201004/04-week.html","https://www.env.go.jp/press/201004/11-week.html","https://www.env.go.jp/press/201004/18-week.html","https://www.env.go.jp/press/201004/25-week.html","https://www.env.go.jp/press/201005/02-week.html","https://www.env.go.jp/press/201005/09-week.html","https://www.env.go.jp/press/201005/16-week.html","https://www.env.go.jp/press/201005/23-week.html","https://www.env.go.jp/press/201005/30-week.html","https://www.env.go.jp/press/201006/06-week.html","https://www.env.go.jp/press/201006/13-week.html","https://www.env.go.jp/press/201006/20-week.html","https://www.env.go.jp/press/201006/27-week.html","https://www.env.go.jp/press/201007/04-week.html","https://www.env.go.jp/press/201007/11-week.html","https://www.env.go.jp/press/201007/18-week.html","https://www.env.go.jp/press/201007/25-week.html","https://www.env.go.jp/press/201008/01-week.html","https://www.env.go.jp/press/201008/08-week.html","https://www.env.go.jp/press/201008/15-week.html","https://www.env.go.jp/press/201008/22-week.html","https://www.env.go.jp/press/201008/29-week.html","https://www.env.go.jp/press/201009/05-week.html","https://www.env.go.jp/press/201009/12-week.html","https://www.env.go.jp/press/201009/19-week.html","https://www.env.go.jp/press/201009/26-week.html","https://www.env.go.jp/press/201010/03-week.html","https://www.env.go.jp/press/201010/10-week.html","https://www.env.go.jp/press/201010/17-week.html","https://www.env.go.jp/press/201010/24-week.html","https://www.env.go.jp/press/201010/31-week.html","https://www.env.go.jp/press/201011/07-week.html","https://www.env.go.jp/press/201011/14-week.html","https://www.env.go.jp/press/201011/21-week.html","https://www.env.go.jp/press/201011/28-week.html","https://www.env.go.jp/press/201012/05-week.html","https://www.env.go.jp/press/201012/12-week.html","https://www.env.go.jp/press/201012/19-week.html","https://www.env.go.jp/press/201012/26-week.html","https://www.env.go.jp/press/201101/02-week.html","https://www.env.go.jp/press/201101/09-week.html","https://www.env.go.jp/press/201101/16-week.html","https://www.env.go.jp/press/201101/23-week.html","https://www.env.go.jp/press/201101/30-week.html","https://www.env.go.jp/press/201102/06-week.html","https://www.env.go.jp/press/201102/13-week.html","https://www.env.go.jp/press/201102/20-week.html","https://www.env.go.jp/press/201102/27-week.html","https://www.env.go.jp/press/201103/06-week.html","https://www.env.go.jp/press/201103/13-week.html","https://www.env.go.jp/press/201103/20-week.html","https://www.env.go.jp/press/201103/27-week.html","https://www.env.go.jp/press/201104/03-week.html","https://www.env.go.jp/press/201104/10-week.html","https://www.env.go.jp/press/201104/17-week.html","https://www.env.go.jp/press/201104/24-week.html","https://www.env.go.jp/press/201105/01-week.html","https://www.env.go.jp/press/201105/08-week.html","https://www.env.go.jp/press/201105/15-week.html","https://www.env.go.jp/press/201105/22-week.html","https://www.env.go.jp/press/201105/29-week.html","https://www.env.go.jp/press/201106/05-week.html","https://www.env.go.jp/press/201106/12-week.html","https://www.env.go.jp/press/201106/19-week.html","https://www.env.go.jp/press/201106/26-week.html","https://www.env.go.jp/press/201107/03-week.html","https://www.env.go.jp/press/201107/10-week.html","https://www.env.go.jp/press/201107/17-week.html","https://www.env.go.jp/press/201107/24-week.html","https://www.env.go.jp/press/201107/31-week.html","https://www.env.go.jp/press/201108/07-week.html","https://www.env.go.jp/press/201108/14-week.html","https://www.env.go.jp/press/201108/21-week.html","https://www.env.go.jp/press/201108/28-week.html","https://www.env.go.jp/press/201109/04-week.html","https://www.env.go.jp/press/201109/11-week.html","https://www.env.go.jp/press/201109/18-week.html","https://www.env.go.jp/press/201109/25-week.html","https://www.env.go.jp/press/201110/02-week.html","https://www.env.go.jp/press/201110/09-week.html","https://www.env.go.jp/press/201110/16-week.html","https://www.env.go.jp/press/201110/23-week.html","https://www.env.go.jp/press/201110/30-week.html","https://www.env.go.jp/press/201111/06-week.html","https://www.env.go.jp/press/201111/13-week.html","https://www.env.go.jp/press/201111/20-week.html","https://www.env.go.jp/press/201111/27-week.html","https://www.env.go.jp/press/201112/04-week.html","https://www.env.go.jp/press/201112/11-week.html","https://www.env.go.jp/press/201112/18-week.html","https://www.env.go.jp/press/201112/25-week.html","https://www.env.go.jp/press/201201/01-week.html","https://www.env.go.jp/press/201201/08-week.html","https://www.env.go.jp/press/201201/15-week.html","https://www.env.go.jp/press/201201/22-week.html","https://www.env.go.jp/press/201201/29-week.html","https://www.env.go.jp/press/201202/05-week.html","https://www.env.go.jp/press/201202/12-week.html","https://www.env.go.jp/press/201202/19-week.html","https://www.env.go.jp/press/201202/26-week.html","https://www.env.go.jp/press/201203/04-week.html","https://www.env.go.jp/press/201203/11-week.html","https://www.env.go.jp/press/201203/18-week.html","https://www.env.go.jp/press/201203/25-week.html","https://www.env.go.jp/press/201204/01-week.html","https://www.env.go.jp/press/201204/08-week.html","https://www.env.go.jp/press/201204/15-week.html","https://www.env.go.jp/press/201204/22-week.html","https://www.env.go.jp/press/201204/29-week.html","https://www.env.go.jp/press/201205/06-week.html","https://www.env.go.jp/press/201205/13-week.html","https://www.env.go.jp/press/201205/20-week.html","https://www.env.go.jp/press/201205/27-week.html","https://www.env.go.jp/press/201206/03-week.html","https://www.env.go.jp/press/201206/10-week.html","https://www.env.go.jp/press/201206/17-week.html","https://www.env.go.jp/press/201206/24-week.html","https://www.env.go.jp/press/201207/01-week.html","https://www.env.go.jp/press/201207/08-week.html","https://www.env.go.jp/press/201207/15-week.html","https://www.env.go.jp/press/201207/22-week.html","https://www.env.go.jp/press/201207/29-week.html","https://www.env.go.jp/press/201208/05-week.html","https://www.env.go.jp/press/201208/12-week.html","https://www.env.go.jp/press/201208/19-week.html","https://www.env.go.jp/press/201208/26-week.html","https://www.env.go.jp/press/201209/02-week.html","https://www.env.go.jp/press/201209/09-week.html","https://www.env.go.jp/press/201209/16-week.html","https://www.env.go.jp/press/201209/23-week.html","https://www.env.go.jp/press/201209/30-week.html","https://www.env.go.jp/press/201210/07-week.html","https://www.env.go.jp/press/201210/14-week.html","https://www.env.go.jp/press/201210/21-week.html","https://www.env.go.jp/press/201210/28-week.html","https://www.env.go.jp/press/201211/04-week.html","https://www.env.go.jp/press/201211/11-week.html","https://www.env.go.jp/press/201211/18-week.html","https://www.env.go.jp/press/201211/25-week.html","https://www.env.go.jp/press/201212/02-week.html","https://www.env.go.jp/press/201212/09-week.html","https://www.env.go.jp/press/201212/16-week.html","https://www.env.go.jp/press/201212/23-week.html","https://www.env.go.jp/press/201212/30-week.html","https://www.env.go.jp/press/201301/06-week.html","https://www.env.go.jp/press/201301/13-week.html","https://www.env.go.jp/press/201301/20-week.html","https://www.env.go.jp/press/201301/27-week.html","https://www.env.go.jp/press/201302/03-week.html","https://www.env.go.jp/press/201302/10-week.html","https://www.env.go.jp/press/201302/17-week.html","https://www.env.go.jp/press/201302/24-week.html","https://www.env.go.jp/press/201303/03-week.html","https://www.env.go.jp/press/201303/10-week.html","https://www.env.go.jp/press/201303/17-week.html","https://www.env.go.jp/press/201303/24-week.html","https://www.env.go.jp/press/201303/31-week.html","https://www.env.go.jp/press/201304/07-week.html","https://www.env.go.jp/press/201304/14-week.html","https://www.env.go.jp/press/201304/21-week.html","https://www.env.go.jp/press/201304/28-week.html","https://www.env.go.jp/press/201305/05-week.html","https://www.env.go.jp/press/201305/12-week.html","https://www.env.go.jp/press/201305/19-week.html","https://www.env.go.jp/press/201305/26-week.html","https://www.env.go.jp/press/201306/02-week.html","https://www.env.go.jp/press/201306/09-week.html","https://www.env.go.jp/press/201306/16-week.html","https://www.env.go.jp/press/201306/23-week.html","https://www.env.go.jp/press/201306/30-week.html","https://www.env.go.jp/press/201307/07-week.html","https://www.env.go.jp/press/201307/14-week.html","https://www.env.go.jp/press/201307/21-week.html","https://www.env.go.jp/press/201307/28-week.html","https://www.env.go.jp/press/201308/04-week.html","https://www.env.go.jp/press/201308/11-week.html","https://www.env.go.jp/press/201308/18-week.html","https://www.env.go.jp/press/201308/25-week.html","https://www.env.go.jp/press/201309/01-week.html","https://www.env.go.jp/press/201309/08-week.html","https://www.env.go.jp/press/201309/15-week.html","https://www.env.go.jp/press/201309/22-week.html","https://www.env.go.jp/press/201309/29-week.html","https://www.env.go.jp/press/201310/06-week.html","https://www.env.go.jp/press/201310/13-week.html","https://www.env.go.jp/press/201310/20-week.html","https://www.env.go.jp/press/201310/27-week.html","https://www.env.go.jp/press/201311/03-week.html","https://www.env.go.jp/press/201311/10-week.html","https://www.env.go.jp/press/201311/17-week.html","https://www.env.go.jp/press/201311/24-week.html","https://www.env.go.jp/press/201312/01-week.html","https://www.env.go.jp/press/201312/08-week.html","https://www.env.go.jp/press/201312/15-week.html","https://www.env.go.jp/press/201312/22-week.html","https://www.env.go.jp/press/201312/29-week.html","https://www.env.go.jp/press/201401/05-week.html","https://www.env.go.jp/press/201401/12-week.html","https://www.env.go.jp/press/201401/19-week.html","https://www.env.go.jp/press/201401/26-week.html","https://www.env.go.jp/press/201402/02-week.html","https://www.env.go.jp/press/201402/09-week.html","https://www.env.go.jp/press/201402/16-week.html","https://www.env.go.jp/press/201402/23-week.html","https://www.env.go.jp/press/201403/02-week.html","https://www.env.go.jp/press/201403/09-week.html","https://www.env.go.jp/press/201403/16-week.html","https://www.env.go.jp/press/201403/23-week.html","https://www.env.go.jp/press/201403/30-week.html","https://www.env.go.jp/press/201404/06-week.html","https://www.env.go.jp/press/201404/13-week.html","https://www.env.go.jp/press/201404/20-week.html","https://www.env.go.jp/press/201404/27-week.html","https://www.env.go.jp/press/201405/04-week.html","https://www.env.go.jp/press/201405/11-week.html","https://www.env.go.jp/press/201405/18-week.html","https://www.env.go.jp/press/201405/25-week.html","https://www.env.go.jp/press/201406/01-week.html","https://www.env.go.jp/press/201406/08-week.html","https://www.env.go.jp/press/201406/15-week.html","https://www.env.go.jp/press/201406/22-week.html","https://www.env.go.jp/press/201406/29-week.html","https://www.env.go.jp/press/201407/06-week.html","https://www.env.go.jp/press/201407/13-week.html","https://www.env.go.jp/press/201407/20-week.html","https://www.env.go.jp/press/201407/27-week.html","https://www.env.go.jp/press/201408/03-week.html","https://www.env.go.jp/press/201408/10-week.html","https://www.env.go.jp/press/201408/17-week.html","https://www.env.go.jp/press/201408/24-week.html","https://www.env.go.jp/press/201408/31-week.html","https://www.env.go.jp/press/201409/07-week.html","https://www.env.go.jp/press/201409/14-week.html","https://www.env.go.jp/press/201409/21-week.html","https://www.env.go.jp/press/201409/28-week.html","https://www.env.go.jp/press/201410/05-week.html","https://www.env.go.jp/press/201410/12-week.html","https://www.env.go.jp/press/201410/19-week.html","https://www.env.go.jp/press/201410/26-week.html","https://www.env.go.jp/press/201411/02-week.html","https://www.env.go.jp/press/201411/09-week.html","https://www.env.go.jp/press/201411/16-week.html","https://www.env.go.jp/press/201411/23-week.html","https://www.env.go.jp/press/201411/30-week.html","https://www.env.go.jp/press/201412/07-week.html","https://www.env.go.jp/press/201412/14-week.html","https://www.env.go.jp/press/201412/21-week.html","https://www.env.go.jp/press/201412/28-week.html","https://www.env.go.jp/press/201501/04-week.html","https://www.env.go.jp/press/201501/11-week.html","https://www.env.go.jp/press/201501/18-week.html","https://www.env.go.jp/press/201501/25-week.html","https://www.env.go.jp/press/201502/01-week.html","https://www.env.go.jp/press/201502/08-week.html","https://www.env.go.jp/press/201502/15-week.html","https://www.env.go.jp/press/201502/22-week.html","https://www.env.go.jp/press/201503/01-week.html","https://www.env.go.jp/press/201503/08-week.html","https://www.env.go.jp/press/201503/15-week.html","https://www.env.go.jp/press/201503/22-week.html","https://www.env.go.jp/press/201503/29-week.html","https://www.env.go.jp/press/201504/05-week.html","https://www.env.go.jp/press/201504/12-week.html","https://www.env.go.jp/press/201504/19-week.html","https://www.env.go.jp/press/201504/26-week.html","https://www.env.go.jp/press/201505/03-week.html","https://www.env.go.jp/press/201505/10-week.html","https://www.env.go.jp/press/201505/17-week.html","https://www.env.go.jp/press/201505/24-week.html","https://www.env.go.jp/press/201505/31-week.html","https://www.env.go.jp/press/201506/07-week.html","https://www.env.go.jp/press/201506/14-week.html","https://www.env.go.jp/press/201506/21-week.html","https://www.env.go.jp/press/201506/28-week.html","https://www.env.go.jp/press/201507/05-week.html","https://www.env.go.jp/press/201507/12-week.html","https://www.env.go.jp/press/201507/19-week.html","https://www.env.go.jp/press/201507/26-week.html","https://www.env.go.jp/press/201508/02-week.html","https://www.env.go.jp/press/201508/09-week.html","https://www.env.go.jp/press/201508/16-week.html","https://www.env.go.jp/press/201508/23-week.html","https://www.env.go.jp/press/201508/30-week.html","https://www.env.go.jp/press/201509/06-week.html","https://www.env.go.jp/press/201509/13-week.html","https://www.env.go.jp/press/201509/20-week.html","https://www.env.go.jp/press/201509/27-week.html","https://www.env.go.jp/press/201510/04-week.html","https://www.env.go.jp/press/201510/11-week.html","https://www.env.go.jp/press/201510/18-week.html","https://www.env.go.jp/press/201510/25-week.html","https://www.env.go.jp/press/201511/01-week.html","https://www.env.go.jp/press/201511/08-week.html","https://www.env.go.jp/press/201511/15-week.html","https://www.env.go.jp/press/201511/22-week.html","https://www.env.go.jp/press/201511/29-week.html","https://www.env.go.jp/press/201512/06-week.html","https://www.env.go.jp/press/201512/13-week.html","https://www.env.go.jp/press/201512/20-week.html","https://www.env.go.jp/press/201512/27-week.html","https://www.env.go.jp/press/201601/03-week.html","https://www.env.go.jp/press/201601/10-week.html","https://www.env.go.jp/press/201601/17-week.html","https://www.env.go.jp/press/201601/24-week.html","https://www.env.go.jp/press/201601/31-week.html","https://www.env.go.jp/press/201602/07-week.html","https://www.env.go.jp/press/201602/14-week.html","https://www.env.go.jp/press/201602/21-week.html","https://www.env.go.jp/press/201602/28-week.html","https://www.env.go.jp/press/201603/06-week.html","https://www.env.go.jp/press/201603/13-week.html","https://www.env.go.jp/press/201603/20-week.html","https://www.env.go.jp/press/201603/27-week.html","https://www.env.go.jp/press/201604/03-week.html","https://www.env.go.jp/press/201604/10-week.html","https://www.env.go.jp/press/201604/17-week.html","https://www.env.go.jp/press/201604/24-week.html","https://www.env.go.jp/press/201605/01-week.html","https://www.env.go.jp/press/201605/08-week.html","https://www.env.go.jp/press/201605/15-week.html","https://www.env.go.jp/press/201605/22-week.html","https://www.env.go.jp/press/201605/29-week.html","https://www.env.go.jp/press/201606/05-week.html","https://www.env.go.jp/press/201606/12-week.html","https://www.env.go.jp/press/201606/19-week.html","https://www.env.go.jp/press/201606/26-week.html","https://www.env.go.jp/press/201607/03-week.html","https://www.env.go.jp/press/201607/10-week.html","https://www.env.go.jp/press/201607/17-week.html","https://www.env.go.jp/press/201607/24-week.html","https://www.env.go.jp/press/201607/31-week.html","https://www.env.go.jp/press/201608/07-week.html","https://www.env.go.jp/press/201608/14-week.html","https://www.env.go.jp/press/201608/21-week.html","https://www.env.go.jp/press/201608/28-week.html","https://www.env.go.jp/press/201609/04-week.html","https://www.env.go.jp/press/201609/11-week.html","https://www.env.go.jp/press/201609/18-week.html","https://www.env.go.jp/press/201609/25-week.html","https://www.env.go.jp/press/201610/02-week.html","https://www.env.go.jp/press/201610/09-week.html","https://www.env.go.jp/press/201610/16-week.html","https://www.env.go.jp/press/201610/23-week.html","https://www.env.go.jp/press/201610/30-week.html","https://www.env.go.jp/press/201611/06-week.html","https://www.env.go.jp/press/201611/13-week.html","https://www.env.go.jp/press/201611/20-week.html","https://www.env.go.jp/press/201611/27-week.html","https://www.env.go.jp/press/201612/04-week.html","https://www.env.go.jp/press/201612/11-week.html","https://www.env.go.jp/press/201612/18-week.html","https://www.env.go.jp/press/201612/25-week.html","https://www.env.go.jp/press/201701/01-week.html","https://www.env.go.jp/press/201701/08-week.html","https://www.env.go.jp/press/201701/15-week.html","https://www.env.go.jp/press/201701/22-week.html","https://www.env.go.jp/press/201701/29-week.html","https://www.env.go.jp/press/201702/05-week.html","https://www.env.go.jp/press/201702/12-week.html","https://www.env.go.jp/press/201702/19-week.html","https://www.env.go.jp/press/201702/26-week.html","https://www.env.go.jp/press/201703/05-week.html","https://www.env.go.jp/press/201703/12-week.html","https://www.env.go.jp/press/201703/19-week.html","https://www.env.go.jp/press/201703/26-week.html","https://www.env.go.jp/press/201704/02-week.html","https://www.env.go.jp/press/201704/09-week.html","https://www.env.go.jp/press/201704/16-week.html","https://www.env.go.jp/press/201704/23-week.html","https://www.env.go.jp/press/201704/30-week.html","https://www.env.go.jp/press/201705/07-week.html","https://www.env.go.jp/press/201705/14-week.html","https://www.env.go.jp/press/201705/21-week.html","https://www.env.go.jp/press/201705/28-week.html","https://www.env.go.jp/press/201706/04-week.html","https://www.env.go.jp/press/201706/11-week.html","https://www.env.go.jp/press/201706/18-week.html","https://www.env.go.jp/press/201706/25-week.html","https://www.env.go.jp/press/201707/02-week.html","https://www.env.go.jp/press/201707/09-week.html","https://www.env.go.jp/press/201707/16-week.html","https://www.env.go.jp/press/201707/23-week.html","https://www.env.go.jp/press/201707/30-week.html","https://www.env.go.jp/press/201708/06-week.html","https://www.env.go.jp/press/201708/13-week.html","https://www.env.go.jp/press/201708/20-week.html","https://www.env.go.jp/press/201708/27-week.html","https://www.env.go.jp/press/201709/03-week.html","https://www.env.go.jp/press/201709/10-week.html","https://www.env.go.jp/press/201709/17-week.html","https://www.env.go.jp/press/201709/24-week.html","https://www.env.go.jp/press/201710/01-week.html","https://www.env.go.jp/press/201710/08-week.html","https://www.env.go.jp/press/201710/15-week.html","https://www.env.go.jp/press/201710/22-week.html","https://www.env.go.jp/press/201710/29-week.html","https://www.env.go.jp/press/201711/05-week.html","https://www.env.go.jp/press/201711/12-week.html","https://www.env.go.jp/press/201711/19-week.html","https://www.env.go.jp/press/201711/26-week.html","https://www.env.go.jp/press/201712/03-week.html","https://www.env.go.jp/press/201712/10-week.html","https://www.env.go.jp/press/201712/17-week.html","https://www.env.go.jp/press/201712/24-week.html","https://www.env.go.jp/press/201712/31-week.html","https://www.env.go.jp/press/201801/07-week.html","https://www.env.go.jp/press/201801/14-week.html","https://www.env.go.jp/press/201801/21-week.html","https://www.env.go.jp/press/201801/28-week.html","https://www.env.go.jp/press/201802/04-week.html","https://www.env.go.jp/press/201802/11-week.html","https://www.env.go.jp/press/201802/18-week.html","https://www.env.go.jp/press/201802/25-week.html","https://www.env.go.jp/press/201803/04-week.html","https://www.env.go.jp/press/201803/11-week.html","https://www.env.go.jp/press/201803/18-week.html","https://www.env.go.jp/press/201803/25-week.html","https://www.env.go.jp/press/201804/01-week.html","https://www.env.go.jp/press/201804/08-week.html","https://www.env.go.jp/press/201804/15-week.html","https://www.env.go.jp/press/201804/22-week.html","https://www.env.go.jp/press/201804/29-week.html","https://www.env.go.jp/press/201805/06-week.html","https://www.env.go.jp/press/201805/13-week.html","https://www.env.go.jp/press/201805/20-week.html","https://www.env.go.jp/press/201805/27-week.html","https://www.env.go.jp/press/201806/03-week.html","https://www.env.go.jp/press/201806/10-week.html","https://www.env.go.jp/press/201806/17-week.html","https://www.env.go.jp/press/201806/24-week.html","https://www.env.go.jp/press/201807/01-week.html","https://www.env.go.jp/press/201807/08-week.html","https://www.env.go.jp/press/201807/15-week.html","https://www.env.go.jp/press/201807/22-week.html","https://www.env.go.jp/press/201807/29-week.html","https://www.env.go.jp/press/201808/05-week.html","https://www.env.go.jp/press/201808/12-week.html","https://www.env.go.jp/press/201808/19-week.html","https://www.env.go.jp/press/201808/26-week.html","https://www.env.go.jp/press/201809/02-week.html","https://www.env.go.jp/press/201809/09-week.html","https://www.env.go.jp/press/201809/16-week.html","https://www.env.go.jp/press/201809/23-week.html","https://www.env.go.jp/press/201809/30-week.html","https://www.env.go.jp/press/201810/07-week.html","https://www.env.go.jp/press/201810/14-week.html",]

pages = []
archive_urls.each do | archive_url |
  begin
    sleep(2)
	  agent = Mechanize.new
	  archive = agent.get(archive_url)

	  anchor_els = archive.search("#main a")

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