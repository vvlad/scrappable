# Scrappable

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'scrappable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scrappable

## Usage


```ruby
class RubyToolbox

  include Scrappable::Page
  self.scrappable_url = "https://www.ruby-toolbox.com/"

  collection_attribute :categories, ".grouped>h4"


end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
