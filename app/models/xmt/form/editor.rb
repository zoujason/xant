module Xmt
  module Form
    class Editor < Input

      def render
        #input = "<textarea  name='#{@name}' class='#{@classname}'>#{@value}</textarea>".html_safe
        Builder.kindeditor(@name)
      end

    end
  end
end