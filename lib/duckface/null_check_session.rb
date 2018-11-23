# frozen_string_literal: true

module Duckface
  class NullCheckSession
    def methods_not_implemented
      []
    end

    def methods_with_incorrect_signatures
      []
    end

    def successful?
      false
    end

    def null?
      true
    end

    alias correctly successful?
  end
end
