# frozen_string_literal: true

require 'duckface/services/check_class_implements_interface'
require 'duckface/implementation_methods'

module Duckface
  # Provides methods on any class to indicate usage of interfaces
  module ObjectSugar
    def check_it_implements(_interface_class)
      false
    end

    def says_it_implements?(_interface_class)
      false
    end

    def implements_interface(interface_class)
      extend Duckface::ImplementationMethods
      include interface_class
    end
  end
end

Class.include(Duckface::ObjectSugar)
