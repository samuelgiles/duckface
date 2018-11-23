# frozen_string_literal: true

module Duckface
  class CheckSession
    def initialize
      @methods_not_implemented = []
      @methods_with_incorrect_signatures = []
    end

    attr_reader :methods_not_implemented,
                :methods_with_incorrect_signatures

    def notice_not_implemented_method(method_name)
      @methods_not_implemented << method_name
    end

    def notice_method_with_incorrect_signature(method_name)
      @methods_with_incorrect_signatures << method_name
    end

    def successful?
      @methods_not_implemented.empty? && @methods_with_incorrect_signatures.empty?
    end

    def null?
      false
    end

    alias correctly successful?
  end
end
