module Xmt
  module Form
    class Text < Input

      def render
        input = "<input type='#{@type}'  name='#{@name}'  value='#{@value}' class='#{@classname}' />".html_safe
      end

    end
  end
end