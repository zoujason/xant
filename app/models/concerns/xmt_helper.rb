module XMTHelper
  module PageAttr

    def attr(name, options = {})
      attr_value = self.instance_eval { eval(name.to_s) } if self.respond_to?(name) || !self.cust_attr.respond_to?(name)
      attr_value = self.cust_attr["#{name}"] if attr_value.blank? && self.cust_attr.respond_to?(name)
      attr_value = options[:default] if options[:default] && attr_value.blank?

      attr_value = hlp_format_date(attr_value, options[:format]) if  attr_value.is_a?(DateTime)
      attr_value = hlp_safe_context(attr_value) if !options[:html_safe].blank? && options[:html_safe].to_s == 'true' && attr_value.is_a?(String)
      attr_value = hlp_clear_mark(attr_value) if  !options[:clear_mark].blank? && options[:clear_mark].to_s == 'true' && attr_value.is_a?(String)
      attr_value = hlp_cut_length(attr_value,options[:len]) if !options[:len].blank? && attr_value.is_a?(String)
      attr_value = hlp_format_number(attr_value,options[:num]) if !options[:num].blank? && attr_value.is_a?(Numeric)

      return attr_value
    end

    private
      def hlp_format_date(field_value, format)
         if !format.blank?
           field_value.strftime(format)
        else
          field_value.strftime('%Y-%m-%d')
        end
      end

      def hlp_format_number(field_value, num = 2)
        field_value.round(num.to_i)
      end

      def hlp_cut_length(field_value, len = 120)
        field_value[0, len]
      end

      def hlp_safe_context(field_value)
        field_value.html_safe
      end

      def hlp_clear_mark(str)
        str && str.gsub!(/<[^>]+>/, '')
        str && str.gsub!(/&emsp;/, '')
        str && str.gsub!(/&emsp;&emsp;/, '')
        str && str.gsub!(/' '/m, '&nbsp;')
        str && str.gsub!(/<\/?.*?>/,'')
        str && str.gsub!(/<\/?.*?/,'')
        str && str.gsub!(/img/,'')
        str
      end

  end
end