$: << File.expand_path("../../lib",__FILE__)

require 'bundler'
Bundler.setup
require 'pp'
require 'scrappable'

class RubyToolbox

  include Scrappable::Page
  self.scrappable_url = "https://www.ruby-toolbox.com/"

  collection_attribute :categories, ".grouped>h4"


end


pp RubyToolbox.new.as_json
