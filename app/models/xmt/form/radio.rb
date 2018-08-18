module Xmt
  module Form
    class Radio < Input

      def render
        options = @options.nil? ? [] : @options.split(",")
        input = ""
        options.each do |option|
          input << "<input name='#{@name}' type='#{@type}' value='#{option.split("|")[0]}' #{ @value==option.split("|")[0] ? 'checked' : '' } />#{option.split("|")[1]}"
        end
        input.html_safe
      end

    end
  end
end