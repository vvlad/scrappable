require 'spec_helper'

describe Scrappable::Attributes do

  let(:html) do
    <<-html.unindent
    <html>
    <head><title>Page Title</title></head>
    <body>
      <h1>Page Header</h1>
      <ul id="stories" title='The story collection title'>
        <li data-isbn="1" >1st story</li>
        <li data-isbn="2" >2nd story</li>
      </ul>
    </body>
    </html>
    html
  end

  let(:scrappable_options) { [] }
  let(:scrappable) { scrappable_class.new(*scrappable_options) }

  let(:scrappable_class) do

    Class.new.class_eval do
      include Scrappable::Attributes

    end.tap do |klass|
      klass.any_instance.stub(:scrappable_html).and_return(html)
    end

  end

  let(:subject) do
   scrappable_class.class_eval do
    attribute :page_title, "head>title"
    attribute :page_header, "body>h1"
    attribute :story_list_title, "#stories", attr: 'title'
    collection_attribute :stories, "#stories>li"
    collection_attribute :isbns, "#stories>li[data-isbn]", attr: 'data-isbn'
   end
   scrappable_class.new
  end

  it "should define an attribute" do
    scrappable_class.class_eval { attribute :test, "html>body" }
    scrappable.respond_to?(:test).should be_true
  end

  it "should define a collection attribute" do
    scrappable_class.class_eval { collection_attribute :stories, "html>body>ul#stories>li.story" }
    scrappable.respond_to?(:stories).should be_true
  end

  its(:page_title) { should eq("Page Title")}
  its(:page_header) { should eq("Page Header")}
  its(:story_list_title) { should eq("The story collection title") }
  its(:stories) { should eq(["1st story","2nd story"]) }
  its(:isbns) { should eq(["1","2"]) }
  its(:as_json) { should eq({
    :page_title => "Page Title",
    :page_header => "Page Header",
    :story_list_title => "The story collection title",
    :stories => ["1st story","2nd story"],
    :isbns => ["1", "2"]
  })}

end
