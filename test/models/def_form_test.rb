require 'test_helper'
class DefFormTest < ActiveSupport::TestCase

   def setup
     @defform = XmtForm::DefForm.create(title:"测试表单",desc:"测试描述")
   end


  def test_form_new
     @defform.def_attrs.create [{attr_name:"title1",title:"标题555",data_type:"text",field_type:"text",seq:1},{attr_name:"title2",title:"标题2555",data_type:"String",field_type:"text",seq:2}]
     assert @defform.save
  end


   def test_form_record_new
         @form_record = XmtForm::FormRecord.create def_form_id:@defform.id,title:@defform.title
          test_form_new
          attr_record = []
         @defform.def_attrs.each do |attr|

           attr_record << {attr_name:"#{attr.attr_name}",attr_data:"555"}
         end
         @form_record.form_attrs.create attr_record
         assert @form_record.save
   end


  def teardown
    @defform.delete
    @form_record.delete
  end


end