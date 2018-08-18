# namespace :xmt do
#   desc "create the dict data"
#   task :aa_setup => :environment do |task, args|
#     client = Mysql2::Client.new(
#         :host => '222.171.105.46', # 主机
#         :username => 'root', # 用户名
#         :password => 'aJjsq12my', # 密码
#         :port => '33896',
#         :database => 'data', # 数据库
#         :encoding => 'gbk' # 编码
#     )
#     #client.execute("SET TEXTSIZE 2147483647")
#     # client.query("SELECT * FROM zxl_ecms_news_d").each do |row|
#     #   client.query(" INSERT INTO zxl_ecms_news_copy6 (id,orderid,cpclassid,cpid,titleurl,isurl,shehestr,title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info) VALUES(#{row['id']},#{row['id']},#{row['cpclassid']},#{row['cpid']},'#{row['titleurl']}',0,'99','#{row['title']}',#{row['classid']},'#{row['newspath']}',12,'manager',1,#{row['newstime']},#{row['truetime']},#{row['lastdotime']},'#{row['fwdw']}','#{row['qccs']}','#{row['gwzl']}','#{row['ztfl']}','#{row['editer']}',1)")
#     # end
#     #
#     # client.query("SELECT * FROM zxl_ecms_news_data_1_d").each do |r|
#     #   client.query(" INSERT INTO zxl_ecms_news_data_1_copy4 (id,classid,writer,newstext) VALUES(#{r['id']},#{r['classid']},'#{r['writer']}','#{r['newstext']}')")
#     # end
#
#     client.query("SELECT * FROM zxl_ecms_news_index_d").each do |r1|
#       client.query(" INSERT INTO zxl_ecms_news_index_copy4 (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{r1['id']},#{r1['classid']},1,#{r1['newstime']},#{r1['truetime']},#{r1['lastdotime']},1)")
#     end
#
#   end
#
#   desc "create the dict data"
#   task :titleurl_setup => :environment do |task, args|
#     client = Mysql2::Client.new(
#         :host => '127.0.0.1', # 主机
#         :username => 'root', # 用户名
#         :password => 'root', # 密码
#         :database => 'test', # 数据库
#         :encoding => 'utf8' # 编码
#     )
#     #client.execute("SET TEXTSIZE 2147483647")
#     arr = []
#     client.query("select * from  zxl_ecms_news_d").each do |row|
#       client.query("select classpath from zxl_enewsclass where classid=#{row['classid']}").each do |r|
#          titleurl = "/"+"#{r['classpath']}"+"/"+"#{row['newspath']}"+"/"+"#{row['id']}"+".html";
#          client.query("update zxl_ecms_news_d  set titleurl = '#{titleurl}',isurl=0  where id=#{row['id']}")
#       end
#       #client.query("update cms_doc_gwgg_copy  set classid = #{row['classid']} where channelId='ff808081262faed701262fd37f5e000f' and  title like '#{row['title']}%'")
#       #p row["classname"]
#     end
#     p arr.size
#   end
#
#
# end
