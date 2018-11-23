# frozen_string_literal: true

require 'spec_helper'
require 'duckface/acts_as_interface'
require 'duckface/object_sugar'

module Duckface
  describe ObjectSugar do
    module ExampleInterface
      include Duckface::ActsAsInterface

      def method; end
    end

    class ExampleImplementation
      implements_interface ExampleInterface
    end

    class ExampleThatDoesNotImplementInterface
      def hello; end
    end

    module AnotherExampleInterface
      include Duckface::ActsAsInterface

      def another_method; end
    end

    describe '.implements_interface' do
      specify do
        expect(ExampleImplementation.included_modules).to include(ExampleInterface)
        expect(ExampleImplementation.singleton_class.included_modules)
          .to include(Duckface::ImplementationMethods)
      end
    end

    describe '.check_it_implements' do
      subject(:check_it_implements) do
        implementation_class.check_it_implements(interface)
      end

      let(:implementation_class) { ExampleImplementation }
      let(:interface) { ExampleInterface }

      let(:check_class_implements_interface_service) do
        instance_double(Services::CheckClassImplementsInterface)
      end

      before do
        allow(Services::CheckClassImplementsInterface)
          .to receive(:new)
          .with(ExampleImplementation, ExampleInterface)
          .and_return(check_class_implements_interface_service)
        allow(Services::CheckClassImplementsInterface)
          .to receive(:new)
          .with(ExampleImplementation, AnotherExampleInterface)
          .and_return(check_class_implements_interface_service)
      end

      context 'when the class does not implement any interfaces' do
        let(:implementation_class) { ExampleThatDoesNotImplementInterface }

        it { is_expected.to be_an_instance_of(NullCheckSession) }
      end

      context 'when the class does implement the given interface' do
        let(:implementation_class) { ExampleImplementation }

        specify do
          expect(check_class_implements_interface_service)
            .to receive(:perform)
            .and_return(true)
          expect(check_it_implements).to be true
        end
      end

      context 'when the class does not implement the given interface' do
        let(:interface) { AnotherExampleInterface }

        specify do
          expect(check_class_implements_interface_service)
            .to receive(:perform)
            .and_return(false)
          expect(check_it_implements).to be false
        end
      end
    end

    describe '.says_it_implements?' do
      subject(:says_it_implements?) do
        implementation_class.says_it_implements?(interface)
      end

      let(:interface) { ExampleInterface }
      let(:implementation_class) { ExampleThatDoesNotImplementInterface }

      context 'when a class does not implement any interfaces' do
        let(:implementation_class) { ExampleThatDoesNotImplementInterface }

        it { is_expected.to be false }
      end

      context 'when a class implements the given interface' do
        let(:implementation_class) { ExampleImplementation }

        it { is_expected.to be true }
      end

      context 'when a class does not implement the given interface' do
        let(:implementation_class) { ExampleImplementation }
        let(:interface) { AnotherExampleInterface }

        it { is_expected.to be false }
      end
    end
  end
end
