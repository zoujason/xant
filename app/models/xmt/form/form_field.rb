module Xmt
  module Form
    class FormField

      def initialize(rdf, name, value, classname,site=nil)
        @rdf = rdf
        @type = rdf.attr_type
        @name = name
        @value = value
        @classname = classname
        @site = site
      end

      def create
        case @type
          when 'text'
            Xmt::Form::Text.new(@rdf, @name, @value, @classname).render
          when 'file'
            Xmt::Form::File.new(@rdf, @name, @value, @classname).render
          when 'select'
            Xmt::Form::Select.new(@rdf, @name, @value, @classname).render
          when 'textarea'
            Xmt::Form::TextArea.new(@rdf, @name, @value, @classname).render
          when 'radio'
            Xmt::Form::Radio.new(@rdf, @name, @value, @classname).render
          when 'checkbox'
            Xmt::Form::CheckBox.new(@rdf, @name, @value, @classname).render
          when 'data'
            Xmt::Form::DataRdf.new(@rdf, @name, @value, @classname,@site).render
          else
            Xmt::Form::Text.new(@rdf, @name, @value, @classname).render
        end
      end
  
    end
  end
end