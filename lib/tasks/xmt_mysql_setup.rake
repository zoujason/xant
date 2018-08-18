namespace :xmt do
  desc "create the dict data"
  task :mysql_setup => :environment do |task, args|

    # Xmt::Stat::PageView.all.each do |c|
    #   c.destroy
    # end
#     client = Mysql2::Client.new(
#         :host => '127.0.0.1', # 主机
#         :username => 'root', # 用户名
#         :password => 'root', # 密码
#         :database => 'test', # 数据库
#         :encoding => 'utf8' # 编码
#     )
# #    client.execute("SET TEXTSIZE 2147483647")
# # results = client.query("SELECT VERSION()")
# # results.each do |row|
# #   puts row
# # end
#
# #puts row['createDate'].strftime("%Y%m%d")
# #puts row['publishDate'].to_i
# #puts client.query(" INSERT INTO zxl_ecms_news (title,classid,newspath,userid,username,havehtml,newstime,fwdw,qccs,gwzl,ztfl,editer,info) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['gwzl']}','#{row['ztfl']}','#{row['author']}',1)")
# #puts insert
# #arr = []
# #"黑龙江省安全生产监督管理局公告(2015年 第12号)"
# #cms_doc_gwgg_aqsc
# #client.query(" INSERT INTO zxl_ecms_news (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1)")
# # lastid = client.last_id
# # str  = row['content']
# # str && str.gsub!(/'Times New Roman'/m,'宋体' )
# # client.query("update zxl_ecms_news  set filename = #{lastid} where id =#{lastid}")
# # client.query(" INSERT INTO zxl_ecms_news_data_1 (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
# # client.query(" INSERT INTO zxl_ecms_news_index (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
# # #client.query("update cms_doc_gwgg  set classid = #{row['classid']},fwdw='#{row['fwdw']}',qccs='#{row['qccs']}',fwzl='#{row['fwzl']}',ztfl='#{row['ztfl']}',ztfl='#{row['ztfl']}' where nid =#{row['id']}")
#
#     # client.query("delete from zxl_ecms_news_copy where classid >17")
#     # client.query("delete from zxl_ecms_news_data_1_copy where classid >17")
#     # client.query("delete from zxl_ecms_news_index_copy where classid >17")
#     #
#     client.query("SELECT * FROM zxl_ecms_news_copy").each do |row|
#       client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info) VALUES('#{row['title']}',#{row['classid']},'#{row['newspath']}',12,'manager',1,#{row['newstime']},#{row['truetime']},#{row['lastdotime']},'#{row['fwdw']}','#{row['qccs']}','#{row['gwzl']}','#{row['ztfl']}','#{row['editer']}',1)")
#       lastid = client.last_id
#       nid = row['id']
#       client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}  where id =#{lastid}")
#       client.query("SELECT * FROM zxl_ecms_news_data_1_copy where id = #{nid}").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{r['classid']},'#{r['writer']}','#{r['newstext']}')")
#       end
#       client.query("SELECT * FROM zxl_ecms_news_index_copy where id = #{nid}").each do |r1|
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{r1['classid']},1,#{row['newstime']},#{r1['truetime']},#{r1['lastdotime']},1)")
#       end
#
#     end
#
#
# #安全生产标准
#     # client.query("SELECT * FROM cms_news_01_aqsc").each do |row|
#     #   client.query("update cms_doc_gwgg_aqsc  set classid = #{row['classid']} where title like '%#{row['title']}%'")
#     # end
#     #client.query("delete from cms_doc_gwgg_aqsc where classid not in(88)")
#     client.query("SELECT * FROM cms_doc_gwgg_aqsc").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid} ,orderid=#{lastid}  where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#
#     end
#     # #安全宣教
#     # client.query("SELECT * FROM cms_news_01_aqxj").each do |row|
#     #   client.query("update cms_doc_gwgg_aqxj  set classid = #{row['classid']} where title like '%#{row['title']}%'")
#     # end
#     # client.query("delete from cms_doc_gwgg_aqxj where classid not in(154)")
#     client.query("SELECT * FROM cms_doc_gwgg_aqxj").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid} where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#     # #非煤矿山
#     # client.query("SELECT * FROM cms_news_01_fmks").each do |row|
#     #   client.query("update cms_doc_gwgg_fmks  set classid = #{row['classid']} where title like '%#{row['title']}%'")
#     # end
#     # client.query("delete from cms_doc_gwgg_fmks where classid not in(67)")
#     client.query("SELECT * FROM cms_doc_gwgg_fmks").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
#     # #发文机关
#     # client.query("SELECT * FROM cms_news_01_fwjg").each do |row|
#     #   client.query("update cms_doc_gwgg_fwjg  set classid = #{row['classid']} where title like '%#{row['title']}%'")
#     # end
#     # client.query("delete from cms_doc_gwgg_fwjg where classid not in(30,31,32)")
#     client.query("SELECT * FROM cms_doc_gwgg_fwjg").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
#    # # #发文机关
#    #  client.query("SELECT * FROM cms_news_01_fwzl").each do |row|
#    #    client.query("update cms_doc_gwgg_fwzl  set classid = #{row['classid']} where title like '%#{row['title']}%'")
#    #  end
#    #  client.query("delete from cms_doc_gwgg_fwzl where classid not in(33,34,35,36,37,38,39,40,41,42,43)")
#     client.query("SELECT * FROM cms_doc_gwgg_fwzl").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # #规划科技
# #     client.query("SELECT * FROM cms_news_01_ghkj").each do |row|
# #       client.query("update cms_doc_gwgg_ghkj  set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_ghkj where classid not in(85)")
#     client.query("SELECT * FROM cms_doc_gwgg_ghkj").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
#
#
# # #公开内容
# #     client.query("SELECT * FROM cms_news_01_gknr").each do |row|
# #       client.query("update cms_doc_gwgg_gknr  set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_gknr where classid not in(58,59,60,61,62,63,64,65,66,119)")
#     client.query("SELECT * FROM cms_doc_gwgg_gknr").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # #q起草部门
# #     client.query("SELECT * FROM cms_news_01_qcbm").each do |row|
# #       client.query("update cms_doc_gwgg_qcbm  set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_qcbm where classid not in(44,45,46,47,48,49,50,51,52,53,54,55,56,57)")
#     client.query("SELECT * FROM cms_doc_gwgg_qcbm").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # #三台
# #     client.query("SELECT * FROM cms_news_01_st").each do |row|
# #       client.query("update cms_doc_gwgg_st set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_st where classid not in(163,164)")
#     client.query("SELECT * FROM cms_doc_gwgg_st").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
# #
# # #统计信息
# #     client.query("SELECT * FROM cms_news_01_tjxx").each do |row|
# #       client.query("update cms_doc_gwgg_tjxx set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_tjxx where classid not in(83)")
#     client.query("SELECT * FROM cms_doc_gwgg_tjxx").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # #危险品
# #     client.query("SELECT * FROM cms_news_01_wxp").each do |row|
# #       client.query("update cms_doc_gwgg_wxp set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_wxp where classid not in(89,91,92)")
#     client.query("SELECT * FROM cms_doc_gwgg_wxp").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # #应急处理
# #     client.query("SELECT * FROM cms_news_01_yjcl").each do |row|
# #       client.query("update cms_doc_gwgg_yjcl set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_yjcl where classid not in(98)")
#     client.query("SELECT * FROM cms_doc_gwgg_yjcl").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # # #冶金等工贸行业
# #     client.query("SELECT * FROM cms_news_01_yjgm").each do |row|
# #       client.query("update cms_doc_gwgg_yjgm set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_yjgm where classid not in(120)")
#     client.query("SELECT * FROM cms_doc_gwgg_yjgm").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
# # # #执法监察
# #     client.query("SELECT * FROM cms_news_01_zfjc").each do |row|
# #       client.query("update cms_doc_gwgg_zfjc set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_zfjc where classid not in(108)")
#     client.query("SELECT * FROM cms_doc_gwgg_zfjc").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid} ,orderid=#{lastid}  where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
#
# # #职业卫生
# #     client.query("SELECT * FROM cms_news_01_zyws").each do |row|
# #       client.query("update cms_doc_gwgg_zyws set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_zyws where classid not in(139)")
#     client.query("SELECT * FROM cms_doc_gwgg_zyws").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
# # #安全培训
# #     client.query("SELECT * FROM cms_news_01_aqpx").each do |row|
# #       client.query("update cms_doc_gwgg_aqpx set classid = #{row['classid']} where title like '%#{row['title']}%'")
# #     end
# #     client.query("delete from cms_doc_gwgg_aqpx where classid not in(99,100,101)")
#     client.query("SELECT * FROM cms_doc_gwgg_aqpx").each do |row|
#       client.query("SELECT * FROM zxl_ecms_news_d where title = '#{row['title']}' and classid in (15,16,17) ").each do |r|
#         client.query(" INSERT INTO zxl_ecms_news_d (title,classid,newspath,userid,username,havehtml,newstime,truetime,lastdotime,fwdw,qccs,gwzl,ztfl,editer,info,cpclassid,cpid) VALUES('#{row['title']}',#{row['classid']},#{row['createDate'].strftime("%Y%m%d")},12,'manager',1,#{row['publishDate'].to_i},#{row['publishDate'].to_i},#{row['publishDate'].to_i},'#{row['fwdw']}','#{row['qccs']}','#{row['fwzl']}','#{row['ztfl']}','#{row['author']}',1,#{r['classid']},#{r['id']})")
#         lastid = client.last_id
#         str = row['content']
#         str && str.gsub!(/'Times New Roman'/m, '宋体')
#         client.query("update zxl_ecms_news_d  set filename = #{lastid},orderid=#{lastid}   where id =#{lastid}")
#         client.query(" INSERT INTO zxl_ecms_news_data_1_d (id,classid,writer,newstext) VALUES(#{lastid},#{row['classid']},'#{row['author']}','#{str}')")
#         client.query(" INSERT INTO zxl_ecms_news_index_d (id,classid,checked,newstime,truetime,lastdotime,havehtml) VALUES(#{lastid},#{row['classid']},1,#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},#{row['createDate'].strftime("%Y%m%d")},1)")
#       end
#     end
#
#
#
  end
end
