module Xmt
  module Form
    class Input

      def initialize(rdf, name, value, classname, site = nil)
        @rdf = rdf
        @type = @rdf.try(:attr_type)
        @name = name
        @value = value
        @classname = classname
        @options = @rdf.try(:def_datas)
        @site = site
        @relation = @rdf.try(:attr_relation)
        @data = @rdf.try(:relation_data)
        @condition = @rdf.try(:attr_condition)
      end

    end
  end
end