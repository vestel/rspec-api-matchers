require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module PageLinks
      class Matcher < Headers::Matcher
        def matches?(response)
          # NOTE: Only use headers.fetch('Link', '') after http://git.io/CUz3-Q
          super && (headers['Link'] || '') =~ %r{<.+?>. rel\="prev"}
        end

        def description
          %Q{include a 'Link' to the previous page}
        end
        alias_method :failure_message, :description

        def failure_message_when_negated
          %Q{not include a 'Link'}
        end
      end
    end
  end
end