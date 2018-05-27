# frozen_string_literal: true

require 'duckface/parameter_pair'

module Duckface
  class ParameterPairs
    def initialize(parameters)
      @parameters = parameters
    end

    def for_comparison
      parameter_pairs.map(&:for_comparison)
    end

    private

    def parameter_pairs
      @parameters.map do |parameter_pair|
        ParameterPair.new(parameter_pair)
      end
    end
  end
end
