require "active_support/concern"
require "active_support/core_ext/class"
require "active_support/core_ext/object/try"
require "nokogiri"

module Scrappable
  module Attributes
    extend ActiveSupport::Concern
    included do
      class_attribute :scrappables
      self.scrappables=[]
    end

    module ClassMethods

      def attribute(attr,selector,options={})
        attr = attr.to_sym
        scrappables << attr
        define_method(attr) do
          instance_variable_get("@#{attr}") || instance_variable_set("@#{attr}", extract_attribute(selector, options))
        end
        attr_writer attr
      end

      def collection_attribute(attr,selector,options={})
        attr = attr.to_sym
        scrappables << attr
        define_method(attr) do
          instance_variable_get("@#{attr}") || instance_variable_set("@#{attr}", extract_collection(selector, options))
        end
        attr_writer attr
      end

    end

    def as_json
      Hash[*scrappables.map { |attr| ["#{attr}".to_sym,send(attr)]}.flatten(1)]
    end


    private
    attr :scrappable_html
    def extract_attribute(selector, options)
      if element = html_element(selector)
        if attr = options[:attr] and node = element.first
          node[attr.to_s]
        else
          element.text.strip
        end
      end
    end


    def extract_collection(selector, options)
      if element = html_element(selector)
        if attr = options[:attr]
          element.map { |el| el[attr].try(:strip) }
        else
          element.map(&:text).map(&:strip)
        end
      else
        []
      end
    end


    def html_element(selector)
      element = (page/selector)
      return element if element.count > 0
    end


    def page
      @page ||=Nokogiri::HTML(scrappable_html)
    end

  end
end
