require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module ContentType
      class Matcher < Headers::Matcher
        attr_accessor :content_type

        def initialize(content_type)
          @content_type = content_type
        end

        def matches?(response)
          super && headers.key?('Content-Type') && content_type.match(headers['Content-Type'])
        end

        def description
          %Q{include 'Content-Type': '#{content_type}'}
        end
        alias_method :failure_message, :description

        def failure_message_when_negated
          %Q{not include 'Content-Type': '#{content_type}'}
        end
      end
    end
  end
end