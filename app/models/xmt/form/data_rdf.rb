module Xmt
  module Form
    class DataRdf < Input

      def render
        case @relation
          when 'channel'
            input = "<select class='#{@classname}' name='#{ @condition=='current' ? @name : @name+'[]' }' #{ @condition=='current' ? '' : 'multiple="multiple"' } >"
            site = Xmt::Press::Channel.where(id:@data).count >0  ? Xmt::Press::Channel.where(id:@data).first : Xmt::Press::Site.first
            ChannelMap.new(site).nested_set_options.each do |channel|
                 input << "<option value='#{channel[1]}' #{@value.include?(channel[1].to_s) ? 'selected' : '' unless @value.blank? }>#{channel[0]}</option>"
               end
            input << "</select>"
            input.html_safe
          when 'dict'
            input = "<select class='#{@classname}' name='#{ @condition=='current' ? @name : @name+'[]' }' #{ @condition=='current' ? '' : 'multiple="multiple"' } >"
            Xmt::Core::Dict.dicts(@data).each do |dict|
              input << "<option value='#{dict.sign}' #{@value.include?(dict.sign.to_s) ? 'selected' : ''  unless @value.blank?  } >#{dict.title}</option>"
            end
            input << "</select>"
            input.html_safe
          when 'dept'
            input = "<select class='#{@classname}' name='#{@name}' #{ @condition=='current' ? '' : 'multiple="multiple"' }>"
            Xmt::Staff::DeptApplication.all.each do |dept|
              input << "<option value='#{dept.id}' #{@value.include?(dept.id.to_s) ? 'selected' : ''   unless @value.blank? } >#{dept.ancestors_and_self_name_format}</option>"
            end
            input << "</select>"
            input.html_safe
          else
            input = "<input type='#{@type}'  name='#{@name}'  value='#{@value}' class='#{@classname}' />".html_safe
        end
      end

    end
  end
end