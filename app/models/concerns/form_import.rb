require "spreadsheet"
class FormImport

  class << self
      def read(file,def_form)
        #XmtForm::FormRecord.where(def_form_id:def_form.id).delete
        file = Spreadsheet.open(file)
        sheet = file.worksheet 0
        sheet.each 1 do |row|
          if  row.formats.count>1
            form =  XmtForm::FormRecord.new(def_form_id:def_form.id)
            def_form.def_attrs.each_with_index  do |attr,index|
              if row[index].is_a?(Numeric)
                row[index] =  row[index].to_i
              end
              form.form_attrs.build({attr_data:row[index],attr_name:attr.id.to_s})
            end
           form.save
          end
        end
      end
  end





end