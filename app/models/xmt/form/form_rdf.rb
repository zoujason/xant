module Xmt
  module Form
    class FormRdf

      def initialize(rdf,site)
        @site = site
        @rdf = rdf
        @type = rdf.attr_type
      end

      def create
        case @type
          when 'data'
            Xmt::Form::Data.new(@rdf,@site).render
          else
            Xmt::Form::DataDef.new(@rdf).render
        end
      end
  
    end
  end
end