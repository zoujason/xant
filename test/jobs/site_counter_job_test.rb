require 'test_helper'

class SiteCounterJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'site counter job' do
    @page = Page.last
    perform_enqueued_jobs do
      SiteCounterJob.perform_later(@page.id.to_s)
    end
    p @page.hits

  end
end
