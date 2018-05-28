# frozen_string_literal: true

require 'duckface/errors'
require 'duckface/method_implementation'

module Duckface
  module Services
    class CheckClassImplementsInterface
      def initialize(implementation_class, interface_class)
        @implementation_class = implementation_class
        @interface_class = interface_class
      end

      def perform
        methods_that_should_be_implemented.each do |method_name|
          check_method_is_implemented(method_name)
          check_method_has_correct_signature(method_name)
        end
        true
      end

      private

      def check_method_is_implemented(method_name)
        return if method_implemented?(method_name)
        raise Errors::InterfaceMethodNotImplementedError, "##{method_name} is not implemented"
      end

      def check_method_has_correct_signature(method_name)
        return if method_has_correct_signature?(method_name)
        raise Errors::ImplementationSignatureIncorrectError,
              "##{method_name} does not have the correct signature"
      end

      def methods_that_should_be_implemented
        @methods_that_should_be_implemented ||= @interface_class.methods_that_should_be_implemented
      end

      def method_implemented?(method_name)
        method_implementation(method_name).owner != @interface_class
      end

      def method_has_correct_signature?(method_name)
        method_implementation(method_name).parameters_for_comparison ==
          interface_implementation(method_name).parameters_for_comparison
      end

      def method_implementation(method_name)
        MethodImplementation.new(@implementation_class, method_name)
      end

      def interface_implementation(method_name)
        MethodImplementation.new(@interface_class, method_name)
      end
    end
  end
end
