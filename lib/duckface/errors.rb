# frozen_string_literal: true

module Duckface
  module Errors
    # Raised when a class does not implement a method
    class InterfaceMethodNotImplementedError < NotImplementedError; end
    # Raised when an implementation method does not have the same signature
    # as the interface
    class ImplementationSignatureIncorrectError < NotImplementedError; end
  end
end
