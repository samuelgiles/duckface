# frozen_string_literal: true

module Duckface
  module ImplementationMethods
    def check_it_implements(interface_class)
      Duckface::Services::CheckClassImplementsInterface.new(self, interface_class).perform
    end

    def says_it_implements?(interface_class)
      included_modules.include?(interface_class)
    end
  end
end
