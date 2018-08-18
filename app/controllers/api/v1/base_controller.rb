class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def paginate(resource)
    resource.page(params[:page]).per(params[:pre])
  end

  def paginate_meta(resource)
    {
        current_page: resource.current_page,
        next_page: resource.next_page,
        prev_page: resource.prev_page,
        total_pages: resource.total_pages,
        total_count: resource.total_count
    }
  end

end
