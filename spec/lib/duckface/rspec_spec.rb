# frozen_string_literal: true

require 'spec_helper'
require 'duckface/rspec'
require 'duckface/acts_as_interface'
require 'duckface/object_sugar'

module Duckface
  module RSpecExampleInterface
    extend Duckface::ActsAsInterface

    def method(_an_argument)
      raise NotImplementedMethod
    end
  end

  class RSpecExampleImplementation
    implements_interface RSpecExampleInterface

    def method(an_argument)
      'Hello world'
    end
  end

  describe RSpecExampleImplementation do
    it_behaves_like 'it implements', RSpecExampleInterface
  end
end
