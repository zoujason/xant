module Xmt
  module Form
    class DataDef

      def initialize(rdf)
        @rdf = rdf
        @type = rdf.attr_type
        @relation = rdf.attr_relation
        @datas = rdf.def_datas
      end


      def render
           input ="<div class='form-group attr_datas'>
                          <label class='col-sm-2 control-label'>默认值</label>
                          <div class='col-sm-6  def_datas'>
                            <input type='text' class='form-control' name='xmt_press_rdf_type[rdf_attrs][][def_datas]'  value='#{@datas}'>
                          </div>
                        </div>"
           input.html_safe
        end
      end
    end
  end
