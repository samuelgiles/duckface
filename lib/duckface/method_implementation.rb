# frozen_string_literal: true

require 'duckface/constants'
require 'duckface/parameter_pairs'

module Duckface
  class MethodImplementation
    def initialize(klass, method_name)
      @klass = klass
      @method_name = method_name
    end

    def parameters_for_comparison
      @parameters_for_comparison ||= begin
        return [] if present_in_schema?

        ParameterPairs.new(parameters).for_comparison
      end
    end

    def owner
      @owner ||= begin
        return @klass if present_in_schema?

        implementation.owner
      end
    end

    private

    def implementation
      @implementation ||= @klass.public_instance_method(@method_name)
    end

    def present_in_schema?
      return false unless schema?
      @klass.schema.keys.include?(@method_name)
    end

    def schema?
      return false unless @klass.respond_to?(:schema)

      @klass.schema.respond_to?(:keys)
    end

    def parameters
      implementation.parameters - Constants::IGNORABLE_PARAMETERS
    end
  end
end
