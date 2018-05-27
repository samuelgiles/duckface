# frozen_string_literal: true

require 'duckface/constants'

module Duckface
  module ActsAsInterface
    def exclude_methods_from_interface_enforcement(*method_names)
      class_variable_set(:@@unenforced_methods, method_names)
    end

    def methods_that_should_be_implemented
      expected_public_instance_methods = public_instance_methods(false)
      unenforced_methods = begin
                             class_variable_get(:@@unenforced_methods)
                           rescue NameError
                             []
                           end
      expected_public_instance_methods - (unenforced_methods || [])
    end
  end
end
