module Xmt
  module Test
    class HomeController < ApplicationController
      include Xmt::Test::SessionHelper
      def index
      end
    end
  end
end

