module Xmt
  module Nav
    class MenuAccessBuilder
      def initialize
        @tag = []
      end

      def header
        @tag << "<table class='table table-striped table-bordered table-hover table-full-width'>"
        @tag << "<thead><tr>"
        @tag << "<th>Name</th>"
        @tag << "<th>Operation</th>"
        @tag << "</tr></thead>"
        @tag << "<tbody>"
      end

      def node_begin(node)
        @tag << "<tr>"
      end

      def node_body(node)
        @tag << "<td style='padding-left:#{20*node.depth}px'>#{node.name}<td>"
        @tag << "<td>"
        [:readonly, :edit, :all].each do |priv|
          @tag << "<input type='hidden' value='#{node.id}' name='permissions[][acopermitable_id]' >"
          @tag << "<input type='checkbox' value='2' name='permissions[][privileges][]' >"
          @tag << "<label for=''>#{priv}</label>"
        end
        @tag << "<td>"
      end

      def node_end
        @tag << "</tr>"
      end

      def group_begin

      end

      def group_end

      end

      def footer
        @tag << "</tbody></table>"
      end

      def result
        @tag.join('')
      end
    end
  end
end