namespace :xmt do
  desc "create the xmt_core_dict data"
  task :dict_setup => :environment do |task, args|
    #
    Xmt::Core::Dict.create title: '站点访问权限', sign: :site_access_type , datatype: :sys
    Xmt::Core::Dict.create [{title: '浏览', sign: :visite, typ: :site_access_type, datatype: :sys},
                 {title: '发稿', sign: :add, typ: :site_access_type, datatype: :sys},
                 {title: '编辑', sign: :edit, typ: :site_access_type, datatype: :sys}]

    Xmt::Core::Dict.create title: '菜单访问权限', sign: :admin_menu_permission, datatype: :sys
    Xmt::Core::Dict.create [{title: '浏览', sign: :view, typ: :admin_menu_permission, datatype: :sys}]

    Xmt::Core::Dict.create title: '文章状态', sign: :article_status, datatype: :sys
    Xmt::Core::Dict.create [{title: '草稿', sign: :draft, typ: :article_status, datatype: :sys},
                 {title: '送审', sign: :pending, typ: :article_status, datatype: :sys},
                 {title: '已审', sign: :reviewed, typ: :article_status, datatype: :sys},
                 {title: '发布', sign: :published, typ: :article_status, datatype: :sys},
                 {title: '隐藏', sign: :hidden, typ: :article_status, datatype: :sys}]

    Xmt::Core::Dict.create title: '推荐等级', sign: :article_rcmds, datatype: :sys
    Xmt::Core::Dict.create [{title: '一级推荐', sign: 1, typ: :article_rcmds, datatype: :sys},
                 {title: '二级推荐', sign: 2, typ: :article_rcmds, datatype: :sys},
                 {title: '三级推荐', sign: 3, typ: :article_rcmds, datatype: :sys},
                 {title: '四级推荐', sign: 4, typ: :article_rcmds, datatype: :sys},
                 {title: '五级推荐', sign: 5, typ: :article_rcmds, datatype: :sys},
                 {title: '六级推荐', sign: 6, typ: :article_rcmds, datatype: :sys},
                 {title: '七级推荐', sign: 7, typ: :article_rcmds, datatype: :sys},
                 {title: '八级推荐', sign: 8, typ: :article_rcmds, datatype: :sys},
                 {title: '九级推荐', sign: 9, typ: :article_rcmds, datatype: :sys}]

    Xmt::Core::Dict.create title: '头条等级', sign: :article_headlines, datatype: :sys
    Xmt::Core::Dict.create [{title: '一级头条', sign: 1, typ: :article_headlines, datatype: :sys},
                 {title: '二级头条', sign: 2, typ: :article_headlines, datatype: :sys},
                 {title: '三级头条', sign: 3, typ: :article_headlines, datatype: :sys},
                 {title: '四级头条', sign: 4, typ: :article_headlines, datatype: :sys},
                 {title: '五级头条', sign: 5, typ: :article_headlines, datatype: :sys},
                 {title: '六级头条', sign: 6, typ: :article_headlines, datatype: :sys},
                 {title: '七级头条', sign: 7, typ: :article_headlines, datatype: :sys},
                 {title: '八级头条', sign: 8, typ: :article_headlines, datatype: :sys},
                 {title: '九级头条', sign: 9, typ: :article_headlines, datatype: :sys}]

    Xmt::Core::Dict.create title: '较真答案', sign: :article_truth_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '真', sign: 1, typ: :article_truth_type, datatype: :sys},
                 {title: '假', sign: 2, typ: :article_truth_type, datatype: :sys}]

    Xmt::Core::Dict.create title: '较真答案', sign: :article_truth_result, datatype: :sys
    Xmt::Core::Dict.create [{title: '参与总票数', sign: 1, typ: :article_truth_result, datatype: :sys},
                 {title: '投真的票数', sign: 2, typ: :article_truth_result, datatype: :sys},
                 {title: '投假的票数', sign: 3, typ: :article_truth_result, datatype: :sys},
                 {title: '求真相票数', sign: 4, typ: :article_truth_result, datatype: :sys}]

    Xmt::Core::Dict.create title: '爱好/领域', sign: :hobbies_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '地理', sign: 1, typ: :hobbies_type, datatype: :sys},
                 {title: '天文', sign: 2, typ: :hobbies_type, datatype: :sys},
                 {title: '音乐', sign: 3, typ: :hobbies_type, datatype: :sys},
                 {title: '美术', sign: 4, typ: :hobbies_type, datatype: :sys},
                 {title: '航空', sign: 5, typ: :hobbies_type, datatype: :sys},
                 {title: '美食', sign: 6, typ: :hobbies_type, datatype: :sys},
                 {title: '阅读', sign: 7, typ: :hobbies_type, datatype: :sys},
                 {title: '科幻', sign: 8, typ: :hobbies_type, datatype: :sys},
                 {title: '发明', sign: 9, typ: :hobbies_type, datatype: :sys},
                 {title: '其他', sign: 10, typ: :hobbies_type, datatype: :sys}]

    Xmt::Core::Dict.create title: '性别类型', sign: :gender_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '男', sign: :male, typ: :gender_type, datatype: :sys},{title: '女', sign: :female, typ: :gender_type, datatype: :sys}]
    Xmt::Core::Dict.create title: '评论状态' ,sign: :comment_type , datatype: :sys
    Xmt::Core::Dict.create [{title: '开启', sign: :open, typ: :comment_type, datatype: :sys},
                 {title: '关闭', sign: :closed, typ: :comment_type, datatype: :sys},
                 {title: '仅注册', sign: :registered_only, typ: :comment_type, datatype: :sys},
                 {title: '审核', sign: :checked, typ: :comment_type, datatype: :sys}]
    Xmt::Core::Dict.create title: '资源模块', sign: :source_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '文章稿件', sign: :articles, typ: :source_type, datatype: :sys},
                                         {title: '留言信息', sign: :gestbooks, typ: :source_type, datatype: :sys}]

    Xmt::Core::Dict.create title:'表单类型',sign: :field_type,datatype: :sys
    Xmt::Core::Dict.create [{title: '文本', sign: :text, typ: :field_type, datatype: :sys},
                 {title: '单选', sign: :radio, typ: :field_type, datatype: :sys},
                 {title: '多选', sign: :checkbox, typ: :field_type, datatype: :sys},
                 {title: '文本区域', sign: :textarea, typ: :field_type, datatype: :sys},
                 {title: '下拉', sign: :select, typ: :field_type, datatype: :sys}]

    Xmt::Core::Dict.create title:'数据类型',sign: :data_type,datatype: :sys
    Xmt::Core::Dict.create [{title: '字符串', sign: :string, typ: :data_type, datatype: :sys},
                 {title: '浮点', sign: :float, typ: :data_type, datatype: :sys},
                 {title: '数字', sign: :int, typ: :data_type, datatype: :sys},
                 {title: '布尔', sign: :boole, typ: :data_type, datatype: :sys}]
    Xmt::Core::Dict.create [{title: '单选题', sign: "Xmt::Test::SingleChoice", typ: :question_typ, datatype: :sys},
                 {title: '多选题', sign:  "Xmt::Test::MultipleChoice", typ: :question_typ, datatype: :sys},
                 {title: '判断题', sign:  "Xmt::Test::BinaryChoice", typ: :question_typ, datatype: :sys}]
    Xmt::Core::Dict.create [{title: '手动', sign: "Xmt::Test::FixExam", typ: :exam_mode, datatype: :sys},
                 {title: '智能', sign: "Xmt::Test::RandExam", typ: :exam_mode, datatype: :sys},
                 {title: '综合', sign: "Xmt::Test::CompEaxm", typ: :exam_mode, datatype: :sys}]

    Xmt::Core::Dict.create title: '部门类型', sign: :dept_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '县政府', sign: :xzf, typ: :dept_type, datatype: :sys},
                            {title: '县委', sign: :xw, typ: :dept_type, datatype: :sys}]

    Xmt::Core::Dict.create title: '体裁类型', sign: :genre_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '机构职能', sign: :agency, typ: :genre_type, datatype: :sys},
                            {title: '法律法规', sign: :law, typ: :genre_type, datatype: :sys},
                            {title: '其他信息', sign: :other, typ: :genre_type, datatype: :sys}]


    Xmt::Core::Dict.create title: '关联类型', sign: :relation_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '关联栏目', sign: :channel, typ: :relation_type, datatype: :sys},
                            {title: '关联枚举', sign: :dict, typ: :relation_type, datatype: :sys}]


    Xmt::Core::Dict.create title: '关联条件', sign: :condition_channel, datatype: :sys
    Xmt::Core::Dict.create [{title: '当前数据', sign: :current, typ: :condition_channel, datatype: :sys},
                            {title: '当前及子类数据', sign: :subclass, typ: :condition_channel, datatype: :sys}]



    Xmt::Core::Dict.create title: '标签类型', sign: :tag_type, datatype: :sys
    Xmt::Core::Dict.create [{title: '列表', sign: :news_list, typ: :tag_type, datatype: :sys},
                            {title: '内容', sign: :news_content, typ: :tag_type, datatype: :sys}]


  end


end
