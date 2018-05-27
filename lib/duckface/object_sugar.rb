# frozen_string_literal: true

require 'duckface/services/check_class_implements_interface'
require 'duckface/implementation_methods'

module Duckface
  # Provides methods on any class for indicate usage of interfaces
  module ObjectSugar
    def implements_interface(interface_class)
      extend Duckface::ImplementationMethods
      include interface_class
    end
  end
end

Object.extend(Duckface::ObjectSugar)
