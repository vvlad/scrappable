require 'spec_helper'




describe Scrappable::Page do
  let(:html) { "the html page" }
  let(:example_class) do
    Class.new do
      include Scrappable::Page
    end
  end

  describe ".scrappable_url" do
    it "should be a string" do
      example_class.scrappable_url =  "http://example.host/"
      example_class.new.scrappable_url.should eq("http://example.host/")
    end

    it "should be a URI" do
      example_class.scrappable_url =  URI.parse("http://example.host/")
      example_class.new.scrappable_url.should eq(URI.parse("http://example.host/"))
    end


    it "should be a proc" do
      proc = Proc.new {}
      proc.should_receive(:call).and_return("http://example.host/")
      example_class.scrappable_url=proc
      example_class.new.url.should eq("http://example.host/")
    end

    it "should be a symbol" do
      example_class.scrappable_url= :build_url
      example_class.class_eval do
        def build_url
          "http://example.host/"
        end
      end
      example_class.new.url.should eq("http://example.host/")
    end
  end

  it "should scrape the page" do
    example_class.scrappable_url =  "http://example.host/"
    example_class.any_instance.stub(:connection).and_return StringIO.new(html)
    example_class.new.scrappable_html.should eq(html)
  end

end
