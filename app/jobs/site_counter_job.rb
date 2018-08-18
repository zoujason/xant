class SiteCounterJob < ApplicationJob
  queue_as :default

  def perform(page_id)
    Page.find(page_id).hit
  end

end
