module Xmt
  module Asset
    module ImagesHelper
      def confirm_str(type)
        if type==:dir
          '确认删除该文件夹以及内部所有文件?'
        else
          '确认删除吗该文件吗?'
        end
      end
    end
  end
end