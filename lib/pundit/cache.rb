require 'request_store'
require 'pundit/cache/version'

module Pundit
  module Cache
    # the policy result for a given user and record should not change during a request
    def cache(method_name)
      wrapped_name = "_uncached_#{method_name}"
      alias_method wrapped_name, method_name
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method_name}
          cache_key = "\#{user&.to_global_id}|\#{record&.to_global_id}|#{method_name}"
          if RequestStore.store[cache_key].nil?
            RequestStore.store[cache_key] = #{wrapped_name}
          else
            RequestStore.store[cache_key]
          end
        end
      RUBY
    end
  end
end
