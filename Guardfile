require 'active_support/core_ext/string'
require 'active_support/inflections'




guard 'bundler' do
  watch('Gemfile')
  watch('scrappable.gemspec')
end


guard 'rspec', :version => 2, :cli => '--colour --fail-fast --format documentation' do
  watch(%r{^spec/.+_spec.rb$})
  watch(%r{^lib/(.+).rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec/" }

  # Rails example
  # watch(%r{^app/(.+).rb$})                              { |m| "spec/#{m[1]}_spec.rb" }
  # watch(%r{^app/controllers/(.+)_(controller).rb$})     { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  # watch(%r{^spec/support/(.+).rb$})                     { "spec/" }
  # watch('config/routes.rb')                             { "spec/routing" }
  # watch('app/controllers/application_controller.rb')    { "spec/controllers" }
  # # Capybara request specs
  # watch(%r{^app/views/(.+)/.*.(erb|haml|slim)$})        { |m| "spec/requests/#{m[1]}_spec.rb" }
  # watch(%r{^spec/factories/(.+).rb$})                   { |m| [ Dir["spec/**/#{m[1]}_controller_spec.rb"], ["spec/models/#{m[1].singularize}_spec.rb"] ].flatten }
end


