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
      @parameters_for_comparison ||= ParameterPairs.new(parameters).for_comparison
    end

    def owner
      @owner ||= implementation.owner
    end

    private

    def implementation
      @implementation ||= @klass.public_instance_method(@method_name)
    end

    def parameters
      implementation.parameters - Constants::IGNORABLE_PARAMETERS
    end
  end
end
