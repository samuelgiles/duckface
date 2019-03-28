# frozen_string_literal: true

require 'duckface/method_implementation'
require 'duckface/check_session'
require 'forwardable'

module Duckface
  module Services
    class CheckClassImplementsInterface
      extend Forwardable

      def initialize(implementation_class, interface_class)
        @implementation_class = implementation_class
        @interface_class = interface_class
        @check_session = CheckSession.new
      end

      def perform
        methods_that_should_be_implemented.each do |method_name|
          check_method_is_implemented(method_name)
          check_method_has_correct_signature(method_name)
        end
        @check_session
      end

      private

      def check_method_is_implemented(method_name)
        return if method_implemented?(method_name)

        notice_not_implemented_method(method_name)
      end

      def_delegators :@check_session,
                     :notice_not_implemented_method,
                     :notice_method_with_incorrect_signature

      def check_method_has_correct_signature(method_name)
        return if method_has_correct_signature?(method_name)

        notice_method_with_incorrect_signature(method_name)
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
