# frozen_string_literal: true

require 'spec_helper'
require 'duckface/object_sugar'
require 'duckface/acts_as_interface'
require 'duckface/services/check_class_implements_interface'

module Duckface
  module Services
    describe CheckClassImplementsInterface do
      module BestExampleInterface
        extend Duckface::ActsAsInterface

        def method(an_argument); end
      end

      class ExampleImplementationWithMissingMethod
        implements_interface BestExampleInterface
      end

      class ExampleImplementationWithIncorrectMethodSignature
        implements_interface BestExampleInterface

        def method(some_argument); end
      end

      class ExampleImplementation
        implements_interface BestExampleInterface

        def method(an_argument); end
      end

      let(:service) { described_class.new(implementation_class, interface_class) }

      let(:implementation_class) { ExampleImplementation }
      let(:interface_class) { BestExampleInterface }

      describe '#perform' do
        subject(:perform) { service.perform }

        context 'when the implementation is correct' do
          it { is_expected.to be true }
        end

        context 'when the implementation has a missing method' do
          let(:implementation_class) { ExampleImplementationWithMissingMethod }

          specify do
            expect { perform }
              .to raise_error(
                Errors::InterfaceMethodNotImplementedError,
                '#method is not implemented'
              )
          end
        end

        context 'when the implementation has a method with an incorrect signature' do
          let(:implementation_class) { ExampleImplementationWithIncorrectMethodSignature }

          specify do
            expect { perform }
              .to raise_error(
                Errors::ImplementationSignatureIncorrectError,
                '#method does not have the correct signature'
              )
          end
        end
      end
    end
  end
end
