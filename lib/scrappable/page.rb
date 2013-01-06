require "active_support/concern"
require "active_support/core_ext/class"
require "open-uri"
module Scrappable
  module Page
    extend ActiveSupport::Concern

    included do
      class_attribute :scrappable_url
    end




    include Attributes

    def url
      url = self.class.scrappable_url
      case url
      when Symbol then send(url)
      when Proc then url.call
      when String,URI then url
      else fail "I don't know how to build url from `#{url.class}'"
      end
    end

    def connection
      @connection = nil if @connection and @connection.closed?
      @connection ||= open(url)
    end
    def scrappable_html
      connection.read
    ensure
      connection.close if connection.respond_to? :close
    end


  end
end
