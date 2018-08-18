module Xmt
  module Form
    class File < Input

      def render
        unless @value.blank?
        if @value[/\.[^\.]+$/]=='.jpg'
        input = "<img src='#{@value}' width='100' height='100'/>"
        else
          input = "<a href='#{@value}'>#{@value}</a>"
        end
        else
          input = ""
        end
        input += "<input type='#{@type}'  name='#{@name}' class='file' />"
        input.html_safe
      end

    end
  end
end