module Xmt
  module Form
    class TextArea < Input

      def render
        input = "<textarea  name='#{@name}' class='#{@classname}'>#{@value}</textarea>".html_safe
      end

    end
  end
end