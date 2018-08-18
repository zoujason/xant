module Xmt
  module Form
    class Data

      def initialize(rdf,site)
        @rdf = rdf
        @site = site
        @type = rdf.attr_type
        @relation = rdf.attr_relation
        @data = rdf.relation_data
        @condition = rdf.attr_condition
      end


      def render
        case @relation
          when 'channel'
            attr_relation = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_relation]' onchange='chang_condition(this,this.value)' required><option value=''>选择关联类型</option>";
            Xmt::Core::Dict.dicts(:relation_type).each do |dict|
              attr_relation+="<option #{@relation==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
                             end
            attr_relation+="</select>"
            html_modle_attr_relation = '<div class="form-group attr_relation">'
            html_modle_attr_relation+= '<label class="col-sm-2 control-label">关联类型</label>'
            html_modle_attr_relation+=  '<div class="col-sm-6">'
            html_modle_attr_relation+=  attr_relation
            html_modle_attr_relation+= '</div>'
            html_modle_attr_relation+=  '</div>'
              modle_html = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_condition]'  required><option value=''>选择关联条件</option>"
                      Xmt::Core::Dict.dicts(:condition_channel).each do |dict|
                       modle_html+="<option #{@condition==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
                        end
              modle_html+="</select>";
              html_field ='<label class="col-sm-2 control-label">关联条件</label>'
              html_field +='<div class="col-sm-6">'
              html_field += modle_html
              html_field += '</div>'

             modle_html_c = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][relation_data]'  required><option value=''>选择关联数据</option>"
                ChannelMap.new(@site).nested_set_options.each do |channel|
                   modle_html_c+="<option  #{@data==channel[1].to_s ? 'selected' : ''} value=#{channel[1]}>#{channel[0]}</option>"
                end
               modle_html_c+="</select>"
              html_modle_c = '<label class="col-sm-2 control-label">关联数据</label>'
              html_modle_c += '<div class="col-sm-6">'
              html_modle_c += modle_html_c
              html_modle_c +='</div>'
              attr_condition = "<div class='form-group attr_condition'>"
              attr_condition += html_field
              attr_condition +="</div>"
              condition_value = "<div class='form-group condition_value'>"
              condition_value += html_modle_c
              condition_value +="</div>"
              (html_modle_attr_relation+attr_condition+condition_value).html_safe
          when 'dict'
            attr_relation = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_relation]' onchange='chang_condition(this,this.value)' required><option value=''>选择关联类型</option>";
            Xmt::Core::Dict.dicts(:relation_type).each do |dict|
              attr_relation+="<option #{@relation==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
            end
            attr_relation+="</select>"
            html_modle_attr_relation = '<div class="form-group attr_relation">'
            html_modle_attr_relation+= '<label class="col-sm-2 control-label">关联类型</label>'
            html_modle_attr_relation+=  '<div class="col-sm-6">'
            html_modle_attr_relation+=  attr_relation
            html_modle_attr_relation+= '</div>'
            html_modle_attr_relation+=  '</div>'
            modle_html = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_condition]'  required><option value=''>选择关联条件</option>"
            Xmt::Core::Dict.dicts(:condition_channel).each do |dict|
              modle_html+="<option #{@condition==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
            end
            modle_html+="</select>";
            html_field ='<label class="col-sm-2 control-label">关联条件</label>'
            html_field +='<div class="col-sm-6">'
            html_field += modle_html
            html_field += '</div>'


            modle_html_c = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][relation_data]'  required><option value=''>选择关联数据</option>"
            Xmt::Core::Dict.where(typ:nil).each do |dict|
              modle_html_c+="<option  #{@data==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
            end
            modle_html_c+="</select>"
            html_modle_c = '<label class="col-sm-2 control-label">关联数据</label>'
            html_modle_c += '<div class="col-sm-6">'
            html_modle_c += modle_html_c
            html_modle_c +='</div>'
            attr_condition = "<div class='form-group attr_condition'>"
            attr_condition += html_field
            attr_condition +="</div>"
            condition_value = "<div class='form-group condition_value'>"
            condition_value += html_modle_c
            condition_value +="</div>"
            (html_modle_attr_relation+attr_condition+condition_value).html_safe
          when 'dept'
            attr_relation = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_relation]' onchange='chang_condition(this,this.value)' required><option value=''>选择关联类型</option>";
            Xmt::Core::Dict.dicts(:relation_type).each do |dict|
              attr_relation+="<option #{@relation==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
            end
            attr_relation+="</select>"
            html_modle_attr_relation = '<div class="form-group attr_relation">'
            html_modle_attr_relation+= '<label class="col-sm-2 control-label">关联类型</label>'
            html_modle_attr_relation+=  '<div class="col-sm-6">'
            html_modle_attr_relation+=  attr_relation
            html_modle_attr_relation+= '</div>'
            html_modle_attr_relation+=  '</div>'
            modle_html = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][attr_condition]'  required><option value=''>选择关联条件</option>"
            Xmt::Core::Dict.dicts(:condition_channel).each do |dict|
              modle_html+="<option #{@condition==dict.sign.to_s ? 'selected' : ''} value=#{dict.sign}>#{dict.title}</option>"
            end
            modle_html+="</select>";
            html_field ='<label class="col-sm-2 control-label">关联条件</label>'
            html_field +='<div class="col-sm-6">'
            html_field += modle_html
            html_field += '</div>'

            modle_html_c = "<select class='form-control'  name='xmt_press_rdf_type[rdf_attrs][][relation_data]'  required><option value=''>选择关联数据</option>"
            Xmt::Staff::DeptApplication.all.each do |dept|
              modle_html_c+="<option  #{@data==dept.id.to_s ? 'selected' : ''} value=#{dept.id}>#{dept.ancestors_and_self_name_format}</option>"
            end
            modle_html_c+="</select>"
            html_modle_c = '<label class="col-sm-2 control-label">关联数据</label>'
            html_modle_c += '<div class="col-sm-6">'
            html_modle_c += modle_html_c
            html_modle_c +='</div>'
            attr_condition = "<div class='form-group attr_condition'>"
            attr_condition += html_field
            attr_condition +="</div>"
            condition_value = "<div class='form-group condition_value'>"
            condition_value += html_modle_c
            condition_value +="</div>"
            (html_modle_attr_relation+attr_condition+condition_value).html_safe
          else
            input = "<textarea  name='' class=''></textarea>".html_safe
        end

        # options = @options.nil? ? [] : @options.split(",")
        # input = "<select class='#{@classname}' name='#{@name}'>"
        # options.each do |option|
        #   input << "<option value='#{option.split("|")[0]}' #{ @value==option.split("|")[0] ? 'selected' : '' } >#{option.split("|")[1]}</option>"
        # end
        # input << "</select>"
        # input.html_safe
      end
    end
  end
end