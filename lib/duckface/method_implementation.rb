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

      schema_keys = @klass.schema.keys
      if schema_keys.first.is_a?(Symbol)
        @klass.schema.keys.include?(@method_name)
      elsif schema_keys.first.respond_to?(:name)
        @klass.schema.keys.map(&:name).include?(@method_name)
      else
        raise "Can't determine schema methods. `Class.schema.keys` returns array of unknown types."
      end
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
