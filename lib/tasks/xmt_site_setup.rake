#encoding:UTF-8
namespace :xmt do
  desc "create the site data"
  task :site_setup => :environment do |task, args|
    rdf = Xmt::Press::PageType.create title: '新闻文章'
    edu = Xmt::Press::Site.create title: '中国依安', subtitle: '中国依安', host: '', slug: 'www', tpl: 'tpl_home', layout: 'theme_yaxzf', mobile: true, skin: 'theme_yaxzf',page_type: rdf
    ccc = Xmt::Press::Channel.create title: '走进依安', tpl: 'tpl_home_index', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c1|
      c1.channels.build title: '县长致辞', tpl: 'tpl_channel_content', content_tpl: 'tpl_content', page_type: rdf
      c1.channels.build title: '依安视频', tpl: 'tpl_channel_content', content_tpl: 'tpl_content', page_type: rdf
      c1.channels.build title: '历史沿革', tpl: 'tpl_channel_content', content_tpl: 'tpl_content', page_type: rdf
      c1.channels.build title: '行政区划', tpl: 'tpl_channel_content', content_tpl: 'tpl_content', page_type: rdf
      c1.channels.build title: '依安印象', tpl: 'tpl_channel_list', content_tpl: 'tpl_content', page_type: rdf do |c11|
        c11.channels.build title: '依安美图', tpl: 'tpl_list_img', content_tpl: 'tpl_content', page_type: rdf
        c11.channels.build title: '依安文艺', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
        c11.channels.build title: '依安故事', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      end
    end

    Xmt::Press::Channel.create title: '依安新闻', tpl: 'tpl_channel_list', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c2|
      c2.channels.build title: '依安要闻', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c2.channels.build title: '公告公示', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c2.channels.build title: '乡镇动态', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c2.channels.build title: '部门之窗', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
    end

    Xmt::Press::Channel.create title: '政务公开', tpl: 'tpl_publish', content_tpl: 'tpl_gkml_content', parent: edu, page_type: rdf do |c3|
      c3.channels.build title: '最新公开', tpl: 'tpl_list_zwgk', content_tpl: 'tpl_gkml_content', page_type: rdf
      c3.channels.build title: '公开目录', tpl: 'tpl_list_gkml', content_tpl: 'tpl_content', page_type: rdf
      c3.channels.build title: '公开制度', tpl: 'tpl_list_zwgk', content_tpl: 'tpl_content', page_type: rdf
      c3.channels.build title: '公开指南', tpl: 'tpl_list_zwgk', content_tpl: 'tpl_content', page_type: rdf
      c3.channels.build title: '公开年报', tpl: 'tpl_list_zwgk', content_tpl: 'tpl_content', page_type: rdf
      c3.channels.build title: '基本公开', tpl: 'tpl_list_zwgk', content_tpl: 'tpl_content', page_type: rdf do |c35|
        c35.channels.build title: '机构概况', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
        c35.channels.build title: '工作报告', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
        c35.channels.build title: '公示公告', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      end
    end

    Xmt::Press::Channel.create title: '政民互动', tpl: 'tpl_list', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c4|
      c4.channels.build title: '在线访谈', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c4.channels.build title: '民意征集', tpl: 'tpl_list', content_tpl: 'tpl_myzj_content', page_type: rdf
      c4.channels.build title: '网上调查', tpl: 'tpl_wsdc', content_tpl: 'tpl_content', page_type: rdf
      c4.channels.build title: '网上咨询', tpl: 'tpl_list_gkml', content_tpl: 'tpl_content', page_type: rdf
      c4.channels.build title: '领导信箱', tpl: 'tpl_list_gkml', content_tpl: 'tpl_content', page_type: rdf
    end
    Xmt::Press::Channel.create title: '为民办事', tpl: 'tpl_services_list', content_tpl: 'tpl_content_services', parent: edu, page_type: rdf
    Xmt::Press::Channel.create title: '投资指南', tpl: 'tpl_channel', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c5|
      c5.channels.build title: '招商项目', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c5.channels.build title: '产业风采', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
    end

    Xmt::Press::Channel.create title: '专题报道', tpl: 'tpl_channel', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c6|
      c6.channels.build title: '脱贫攻坚', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c6.channels.build title: '美丽乡村', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c6.channels.build title: '十九大专题', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c6.channels.build title: '双随机一公开', tpl: '	tpl_list_gk', content_tpl: 'tpl_content', page_type: rdf do |c61|
        c61.channels.build title: '人社局', tpl: 'tpl_list_gk_content', content_tpl: 'tpl_content', page_type: rdf
        c61.channels.build title: '市场局', tpl: 'tpl_list_gk_content', content_tpl: 'tpl_content', page_type: rdf
      end
    end
    Xmt::Press::Channel.create title: '图片链接', tpl: 'tpl_channel', content_tpl: 'tpl_content', parent: edu, page_type: rdf do |c7|
      c7.channels.build title: '第三层', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c7.channels.build title: '第二层', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c7.channels.build title: '第一层', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
      c7.channels.build title: '轮播图', tpl: 'tpl_list', content_tpl: 'tpl_content', page_type: rdf
    end


    #单页
    # SinglePage.create title: '关于我们', tpl: 'tpl_singlepage', sign: 'kp_about', parent: edu
    Xmt::Press::SinglePage.create title: '联系我们', tpl: 'tpl_content', sign: 'contact', parent: edu
    Xmt::Press::SinglePage.create title: '网站地图', tpl: 'tpl_site_map', sign: 'contact', parent: edu
    Xmt::Press::SinglePage.create title: '全站搜索', tpl: 'tpl_search', sign: 'search', parent: edu
    Xmt::Press::SinglePage.create title: '依申请公开', tpl: 'tpl_ysqgk', sign: 'ysqgk', parent: edu
    Xmt::Press::SinglePage.create title: '依申请公开', tpl: 'tpl_ysqgk_check', sign: 'ysqgk_check', parent: edu
    Xmt::Press::SinglePage.create title: '我的依申请公开', tpl: 'tpl_ysqgk_list', sign: 'my_ysqgk', parent: edu
    Xmt::Press::SinglePage.create title: '依申请公共详情', tpl: 'tpl_ysqgk_show', sign: 'ysqgk_show', parent: edu
    Xmt::Press::SinglePage.create title: '网上咨询', tpl: 'tpl_ask', sign: 'ask', parent: edu
    Xmt::Press::SinglePage.create title: '我的咨询', tpl: 'tpl_ask_check', sign: 'ask_check', parent: edu
    Xmt::Press::SinglePage.create title: '我的咨询', tpl: 'tpl_ask_list', sign: 'my_ask', parent: edu
    Xmt::Press::SinglePage.create title: '我的咨询', tpl: 'tpl_ask_show', sign: 'ask_show', parent: edu
    Xmt::Press::SinglePage.create title: '网上调查', tpl: 'tpl_vote', sign: 'vote', parent: edu
    Xmt::Press::SinglePage.create title: '调查统计', tpl: 'tpl_vote_count', sign: 'count', parent: edu
    Xmt::Press::SinglePage.create title: '网上调查', tpl: 'tpl_wsdc_content', sign: 'info', parent: edu
    Xmt::Press::SinglePage.create title: '县委', tpl: 'tpl_content', sign: 'xianwei', parent: edu
    Xmt::Press::SinglePage.create title: '县人大', tpl: 'tpl_content', sign: 'renda', parent: edu
    Xmt::Press::SinglePage.create title: '县政府', tpl: 'tpl_content', sign: 'zf', parent: edu
    Xmt::Press::SinglePage.create title: '县政协', tpl: 'tpl_content', sign: 'zx', parent: edu
    Xmt::Press::SinglePage.create title: '举报投诉', tpl: 'tpl_content', sign: 'jubao', parent: edu
    Xmt::Press::SinglePage.create title: '为民服务热线', tpl: 'tpl_content', sign: 'about', parent: edu
    Xmt::Press::SinglePage.create title: '12380举报', tpl: 'tpl_advice_new', sign: 'advice', parent: edu
    Xmt::Press::SinglePage.create title: '提交成功', tpl: 'tpl_advice_check', sign: 'advice', parent: edu
    # SinglePage.create title: '客户服务', tpl: 'tpl_singlepage', sign: 'kp_service', parent: edu
    # SinglePage.create title: '诚聘英才', tpl: 'tpl_singlepage', sign: 'kp_jobs', parent: edu
    # SinglePage.create title: '通行证注册', tpl: 'tpl_singlepage', sign: 'kp_pass', parent: edu
    # SinglePage.create title: '产品答疑', tpl: 'tpl_singlepage', sign: 'kp_product', parent: edu
    # SinglePage.create title: '会员登录', tpl: 'tpl_member_login', sign: 'kp_member_login', parent: edu
    # SinglePage.create title: '会员注册', tpl: 'tpl_member_register', sign: 'kp_member_register', parent: edu
    # SinglePage.create title: '会员主页', tpl: 'tpl_member_main', sign: 'kp_member_main', parent: edu
    # SinglePage.create title: '发表稿件', tpl: 'tpl_member_article_add', sign: 'kp_article_add', parent: edu
    # SinglePage.create title: '我的文章', tpl: 'tpl_member_article_index', sign: 'kp_article_index', parent: edu
    # SinglePage.create title: '编辑稿件', tpl: 'tpl_member_article_edit', sign: 'kp_article_edit', parent: edu
    # SinglePage.create title: '编辑个人信息', tpl: 'tpl_member_info_edit', sign: 'kp_member_info_edit', parent: edu
    # SinglePage.create title: '查看个人信息', tpl: 'tpl_member_info_show', sign: 'kp_member_info_show', parent: edu
    # SinglePage.create title: '我的评论', tpl: 'tpl_member_comment', sign: 'kp_member_comment', parent: edu
    # SinglePage.create title: '注册条款', tpl: 'tpl_member_rule', sign: 'kp_member_rule', parent: edu
    # SinglePage.create title: '修改密码（发送邮件）', tpl: 'forget', sign: 'forget', parent: edu
    # SinglePage.create title: '修改密码（设置密码）', tpl: 'password', sign: 'password', parent: edu


  end
end