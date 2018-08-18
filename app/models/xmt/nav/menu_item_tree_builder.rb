module Xmt
  module Nav
    class MenuItemTreeBuilder

      def initialize(menu)
        @menu = menu
        @tag = MarkBuilder.new
      end

      def build
        me = self
        menu = @menu
        @tag.table 'class': 'table table-striped table-bordered table-hover table-full-width' do
          thead do
            th '名称'
            th '路径'
            th '操作', 'class': 'text-center'
          end
          tbody do
            me.line(menu)
          end
        end
      end

      def line(item)
        me = self
        item.children.each do |child|
          @tag.tr do
            td "<i class='#{child.icon}'></i>" + child.name, style: "padding-left: #{child.depth}em"
            td child.path
            td 'class': 'center' do

              div 'class': 'visible-md visible-lg hidden-sm hidden-xs' do
                a 'class': "btn btn-xs btn-green tooltips btn-wrap", 'data-placement': "top", title: "", href: "/xmt/nav/menu_items/#{child.id}", 'data-original-title': "查看" do
                  i 'class': "fa fa-eye"
                end
                a 'class': "btn btn-xs btn-teal tooltips btn-wrap", 'data-placement': "top", title: "", href: "/xmt/nav/menu_items/#{child.id}/edit?parent_id=#{child.root.id}", 'data-original-title': "修改" do
                  i 'class': "fa fa-edit"
                end
                a 'class': "btn btn-xs btn-bricky tooltips btn-wrap", 'data-placement': "top", title: "", href: "/xmt/nav/menu_items/#{child.id}", 'data-original-title': "删除", 'data-confirm': "确定删除?", rel: "nofollow", 'data-method': "delete" do
                  i 'class': "fa fa-times"
                end
              end

              div 'class': 'visible-xs visible-sm hidden-md hidden-lg' do
                div 'class': 'btn-group' do
                  a 'class': 'btn btn-primary dropdown-toggle btn-sm', 'data-toggle': 'dropdown', 'hraf': '/xmt/nav/menu_items/#{child.id}' do
                    i 'class': 'clip-cog'
                    span 'class': 'caret'
                  end
                  ul 'class': 'dropdown-menu pull-right', 'role': 'menu' do
                    li 'role': 'presentation' do
                      a 'role': 'menuitem', 'tabindex': '-1', 'href': "/xmt/nav/menu_items/#{child.id}/edit?parent_id=#{child.root.id}" do
                        i 'class': 'clip-pencil' do
                        end
                        e 'Edit'
                      end
                    end
                    li 'role': 'presentation' do
                      a 'role': 'menuitem', 'tabindex': '-1', 'href': "/xmt/nav/menu_items/#{child.id}", 'data-confirm': "Are you sure?", rel: "nofollow", 'data-method': "delete" do
                        i 'class': 'clip-close-2' do
                        end
                        e 'Remove'
                      end
                    end
                  end

                end
              end


            end
          end
          me.line(child)
        end
      end

      def to_s
        @tag.to_s
      end

    end
  end
end