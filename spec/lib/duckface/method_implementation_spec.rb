# frozen_string_literal: true

require 'spec_helper'
require 'duckface/method_implementation'

module Duckface
  describe MethodImplementation do
    class ExampleMethodTest
      def some_method(_an_argument)
        puts 'Hello World'
      end
    end

    class ExampleStruct
      def self.schema
        {
          my_struct_attribute: 'String'
        }
      end
    end

    let(:method_implementation) { MethodImplementation.new(ExampleMethodTest, :some_method) }

    describe '#parameters_for_comparison' do
      subject(:parameters_for_comparison) { method_implementation.parameters_for_comparison }

      let(:parameter_pairs_for_comparison) { [%i[req an_argument]] }
      let(:parameter_pairs) { instance_double(ParameterPairs) }

      before do
        allow(ParameterPairs)
          .to receive(:new)
          .with([%i[req _an_argument]])
          .and_return(parameter_pairs)
        allow(parameter_pairs)
          .to receive(:for_comparison)
          .and_return(parameter_pairs_for_comparison)
      end

      it { is_expected.to eq parameter_pairs_for_comparison }

      context 'with a struct' do
        let(:method_implementation) { MethodImplementation.new(ExampleStruct, :my_struct_attribute) }

        it { is_expected.to eq [] }
      end
    end

    describe '#owner' do
      subject(:owner) { method_implementation.owner }

      it { is_expected.to eq ExampleMethodTest }

      context 'with a struct' do
        let(:method_implementation) { MethodImplementation.new(ExampleStruct, :my_struct_attribute) }

        it { is_expected.to eq ExampleStruct }
      end
    end
  end
end
