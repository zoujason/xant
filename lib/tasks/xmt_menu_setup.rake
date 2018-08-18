namespace :xmt do
  desc "create the xmt_nav_menu data"
  task :menu_setup => :environment do |task, args|
    sys = Xmt::Nav::Menu.create(name: '系统菜单', sign: 'sys_menu', datatype: :sys)
    Xmt::Nav::MenuItem.create(name: '首页', path: '/xmt', icon: 'fa fa-home', parent: sys, datatype: :sys)
    Xmt::Nav::MenuItem.create(name: '内容管理', path: '/xmt', icon: 'fa fa-pencil-square-o', parent: sys, datatype: :sys) do |m1|
      m1.children.build(name: '站点管理', path: '/xmt/press/sites', datatype: :sys)
      m1.children.build(name: '资源管理', path: '/xmt/press/page_types', datatype: :sys)
      m1.children.build(name: '频道管理', path: '/xmt/press/channels', datatype: :sys)
      m1.children.build(name: '文章管理', path: '/xmt/press/articles', datatype: :sys)
      m1.children.build(name: '单页管理', path: '/xmt/press/single_pages', datatype: :sys)
      # m1.children.build(name: '模板管理', path: '/xmt/press/templates', datatype: :sys)
      # m1.children.build(name: '标签管理', path: '/xmt/press/snippets', datatype: :sys)
      m1.children.build(name: '文章回收站', path: '/xmt/press/articles/recycle', datatype: :sys)

      #m1.children.build(name: '图片管理', path: '/xmt/images', datatype: :sys)
      #m1.children.build(name: '文档管理', path: '/xmt/documents', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name: '系统管理', path: '/xmt', icon: 'fa fa-cog', parent: sys, datatype: :sys) do |m2|
      m2.children.build(name: '菜单管理', path: '/xmt/nav/menus', datatype: :sys)
      m2.children.build(name: '菜单项管理', path: '/xmt/nav/menu_items', datatype: :sys)
      m2.children.build(name: '字典管理', path: '/xmt/core/dicts', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name: '权限管理', path: '/xmt', icon: 'fa fa-key', parent: sys, datatype: :sys) do |m3|
      m3.children.build(name: '权限组管理', path: '/xmt/rbac/groups', datatype: :sys)
      m3.children.build(name: '角色管理', path: '/xmt/rbac/roles', datatype: :sys)
      m3.children.build(name: '部门管理', path: '/xmt/staff/dept_applications', datatype: :sys)
      m3.children.build(name: '用户管理', path: '/xmt/staff/managers', datatype: :sys)
      m3.children.build(name: '会员管理', path: '/xmt/staff/members', datatype: :sys)
      m3.children.build(name: '菜单访问', path: '/xmt/rbac/menu_accesses', datatype: :sys)
      m3.children.build(name: '站点访问', path: '/xmt/rbac/site_accesses', datatype: :sys)
      m3.children.build(name: '部门管理', path: '/xmt/staff/dept_applications', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name:'互动管理', path:'/xmt',icon: 'fa fa-comments-o', parent:sys, datatype: :sys) do |m4|
      # m4.children.build(name:'留言管理', path: '/xmt/faq/messages', datatype: :sys)
      # m4.children.build(name:'网上咨询', path: '/xmt/faq/consultations', datatype: :sys)
      m4.children.build(name:'民意征集', path: '/xmt/press/comments', datatype: :sys)
      m4.children.build(name:'问卷调查', path: '/xmt/faq/polls', datatype: :sys)
      m4.children.build(name:'公告管理', path: '/xmt/sms/notifications', datatype: :sys)
      m4.children.build(name:'举报管理', path: '/xmt/faq/tips', datatype: :sys)
      m4.children.build(name:'依申请公开', path: '/xmt/faq/sharedocs', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name:'答题管理', path:'/xmt',icon: 'fa fa-file-text', parent:sys, datatype: :sys) do |m5|
      m5.children.build(name:'分类管理', path: '/xmt/test/categories', datatype: :sys)
      m5.children.build(name:'题库管理', path: '/xmt/test/questions', datatype: :sys)
      m5.children.build(name:'考试管理', path: '/xmt/test/exams', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name:'资源管理', path:'/xmt',icon: 'fa fa-files-o', parent:sys, datatype: :sys) do |m6|
      m6.children.build(name:'图片管理', path: '/xmt/asset/images', datatype: :sys)
      m6.children.build(name:'js文件管理', path: '/xmt/asset/scripts', datatype: :sys)
      m6.children.build(name:'css文件管理', path: '/xmt/asset/styles', datatype: :sys)
      m6.children.build(name: '模板管理', path: '/xmt/press/templates', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name:'标签管理', path:'/xmt',icon: 'fa fa-tags', parent:sys, datatype: :sys) do |m7|
      m7.children.build(name:'标签生成器', path: '/xmt/press/snippets', datatype: :sys)
    end

    Xmt::Nav::MenuItem.create(name:'站点统计', path:'/xmt',icon: 'fa fa-bar-chart', parent:sys, datatype: :sys) do |m8|
      m8.children.build(name:'页面年访问统计', path: '/xmt/stat/page_views/page_by_year', datatype: :sys)
      m8.children.build(name:'页面月访问统计', path: '/xmt/stat/page_views/page_by_month', datatype: :sys)
      m8.children.build(name:'频道年访问统计', path: '/xmt/stat/page_views/channel_by_year', datatype: :sys)
      m8.children.build(name:'频道月访问统计', path: '/xmt/stat/page_views/channel_by_month', datatype: :sys)
      m8.children.build(name:'文章年访问统计', path: '/xmt/stat/page_views/article_by_year', datatype: :sys)
      m8.children.build(name:'文章月访问统计', path: '/xmt/stat/page_views/article_by_month', datatype: :sys)
    end

  end
end
