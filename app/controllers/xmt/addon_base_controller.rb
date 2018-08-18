module Xmt
  class AddonBaseController < AdminController
    prepend_view_path "vendor/addons"
  end
end

