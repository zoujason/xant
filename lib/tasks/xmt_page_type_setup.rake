#encoding:UTF-8
namespace :xmt do
  desc "create the site data"
  task :site_setup => :environment do |task, args|
    rdf = Xmt::Press::PageType.create title: '网上咨询'
    rdf.page_attrs.create([
                              {title:'联系电话',sign:'tel',attr_type:'text'},
                              {title:'邮箱',sign:'email',attr_type:'text'},
                              {title:'身份证号码',sign:'cardid',attr_type:'text'},
                              {title:'通讯地址',sign:'address',attr_type:'text'},
                              {title:'咨询内容',sign:'cont',attr_type:'text'},
                              {title:'回复内容',sign:'reply',attr_type:'text'},
                              {title:'是否公开',sign:'ispub',attr_type:'radio'},
                              {title:'是否显示',sign:'isshow',attr_type:'radio'},
                              {title:'回复时间',sign:'replytime',attr_type:'datetime'},
                              {title:'是否审核',sign:'checked',attr_type:'radio'},
                              {title:'回复人',sign:'replyname',attr_type:'text'},
                          ])

  end
end