module Helpers
  
  def camelize_keys_for h
    Hash[h.map { |k,v| [k.to_s.camelize(:lower), v]}]
  end
end

RSpec.configure do |config|
  config.include Helpers
end