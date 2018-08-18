require 'test_helper'

class XmtForm::DefFormTest < ActiveSupport::TestCase
  def setup
    @defform = XmtForm::DefForm.create(title:"测试表单",desc:"测试描述")
  end


  def test_form_new
    @defform.def_attrs.create [{attr_name:"title1",title:"标题555",data_type:"text",field_type:"text",seq:1},{attr_name:"title2",title:"标题2555",data_type:"String",field_type:"text",seq:2}]
    assert @defform.save
  end

end
