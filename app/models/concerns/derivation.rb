require "spreadsheet"
class Derivation
  def self.news_file(def_form)
    Spreadsheet.client_encoding="utf-8"
    book=Spreadsheet::Workbook.new
    sheet1=book.create_worksheet :name => "#{def_form.title}"
    def_form.def_attrs.each_with_index do |form,index|
      sheet1.row(0)[index]="#{form.title}"
    end
    file=File.new("#{Rails.root}/public/form_down/#{def_form.title}.xls","w+")
    file.chmod(0777)
    book.write file
    file.close
  end
end
