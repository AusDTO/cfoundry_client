class CfoundryClient
  module Errors
    class Error < StandardError; end
    class ArgError < Error; end
    class StateError < Error; end
  end
end