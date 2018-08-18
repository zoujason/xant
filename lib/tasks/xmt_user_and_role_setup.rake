namespace :xmt do
  desc "create the user and role data"
  task :user_and_role_setup => :environment do |task, args|
    sys_admin = Xmt::Rbac::Role.create name: '系统管理员', sign: 'sys_admin', datatype: :sys
    admin = Xmt::Rbac::Role.create name: '站长', sign: 'admin', datatype: :sys
    moderator = Xmt::Rbac::Role.create name: '版主', sign: 'moderator', datatype: :sys
    editor = Xmt::Rbac::Role.create name: '小编', sign: 'editor', datatype: :sys
    writer = Xmt::Rbac::Role.create name: '撰稿人', sign: 'writer', datatype: :sys
    commentator = Xmt::Rbac::Role.create name: '评论人', sign: 'commentator', datatype: :sys

    Xmt::Rbac::Group.create name: '管理组', roles: [admin], datatype: :sys
    Xmt::Rbac::Group.create name: '编辑组', roles: [editor, writer, commentator], datatype: :sys
    Xmt::Rbac::Group.create name: '栏目组', roles: [moderator, writer, commentator], datatype: :sys

    Xmt::Staff::Manager.create username: 'manager', password: 'manager', roles: [admin], datatype: :sys
    Xmt::Staff::Manager.create username: 'editor', password: 'editor', roles: [editor], datatype: :sys
    Xmt::Staff::Manager.create username: 'admin', password: 'admin123', roles: [sys_admin], datatype: :sys
  end
end
