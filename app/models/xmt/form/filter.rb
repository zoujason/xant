module Xmt
  module Form
    class Filter
      def self.filte(data,rdf)
          @rdf = Xmt::Press::PageType.find(rdf)
          data.each_pair do |key,value|
            attr_type = @rdf.page_attrs.where(sign:key).first
            unless attr_type.nil?
            data[key]=  self.filtly(attr_type,value)
            end
          end
          data
      end


      def self.filtly(key,value)
        case key
          when 'file'
            LoadImage.upload(value)
          else
            value
        end
      end

    end
  end
end