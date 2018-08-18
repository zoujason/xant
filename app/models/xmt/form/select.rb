module Xmt
  module Form
    class Select < Input

      def render
        options = @options.nil? ? [] : @options.split(",")
        input = "<select class='#{@classname}' name='#{@name}'>"
        options.each do |option|
          input << "<option value='#{option.split("|")[0]}' #{ @value==option.split("|")[0] ? 'selected' : '' } >#{option.split("|")[1]}</option>"
        end
        input << "</select>"
        input.html_safe
      end
    end
  end
end