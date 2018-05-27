# frozen_string_literal: true

module Duckface
  # Takes a method parameters and prepares them for comparison
  class ParameterPair
    def initialize(parameter_pair)
      @parameter_pair = parameter_pair
    end

    def for_comparison
      [@parameter_pair.first, argument_name_without_leading_underscore]
    end

    private

    UNDERSCORE = '_'
    FIRST_CHARACTER = 0

    # Leading underscores are used to indicate a parameter isn't used
    def argument_name_without_leading_underscore
      name = if argument_name_string[FIRST_CHARACTER] == UNDERSCORE
               argument_name_string.reverse.chop.reverse
             else
               argument_name_string
             end
      name.to_sym
    end

    def argument_name_string
      @parameter_pair.last.to_s
    end

    private_constant :UNDERSCORE
  end
end
