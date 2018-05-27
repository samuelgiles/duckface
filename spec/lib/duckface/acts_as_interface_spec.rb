# frozen_string_literal: true

require 'spec_helper'
require 'duckface/acts_as_interface'

module Duckface
  describe ActsAsInterface do
    module ExampleInterfaceTest
      extend Duckface::ActsAsInterface

      exclude_methods_from_interface_enforcement :ignoreable_method_a, :ignoreable_method_b

      def i_need_to_be_implemented
        puts 'I need to be implemented'
      end

      def ignoreable_method_a
        puts 'I should be ignored'
      end

      def ignoreable_method_b
        puts 'And I should be ignored'
      end
    end

    let(:interface) { ExampleInterfaceTest }

    describe '.exclude_methods_from_interface_enforcement' do
      subject(:unenforced_methods) { interface.class_variable_get(:@@unenforced_methods) }

      it { is_expected.to contain_exactly(:ignoreable_method_a, :ignoreable_method_b) }
    end

    describe '.methods_that_should_be_implemented' do
      subject(:methods_that_should_be_implemented) { interface.methods_that_should_be_implemented }

      it { is_expected.to contain_exactly(:i_need_to_be_implemented) }
    end
  end
end
