module Xmt
  module Stat
    class StatMonthChannelBuilder
      def initialize(site)
        @site = site
        @tag = []
      end

      def header_stat
        @tag << "<ul class='dropdown-menu dropdown-info dropdown-menu-step'>"
      end

      def node_begin_stat
        @tag << "<li>"
      end

      def node_body_stat(node)
        @tag << "<a href='/xmt/stat/page_views/search_by_month?page_parent_ids=#{node.id}&kind=0' >#{node.title}</a>"
      end

      def node_end_stat
        @tag << "</li>"
      end


      def group_begin_stat
        @tag << "<li>"
      end

      def group_body_stat(node)
        @tag << "<a href='/xmt/stat/page_views/search_by_month?page_parent_ids=#{node.id}&kind=0'><i class='fa fa-angle-right menu-item-right'></i>#{node.title}</a><ul class='dropdown-menu-child'>"
      end

      def group_end_stat
        @tag << "</ul></li>"
      end

      def footer_stat
        @tag << "</ul>"
      end

      def result_stat
        @tag.join('')
      end

    end
  end
end