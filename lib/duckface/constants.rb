# frozen_string_literal: true

module Duckface
  module Constants
    UNENFORCED_METHODS_CONSTANT_NAME = 'UNENFORCED_METHODS'
    IGNORABLE_PARAMETERS = [%i[block block], %i[rest args]].freeze
  end
end
