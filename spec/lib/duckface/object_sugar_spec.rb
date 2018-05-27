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

    describe '.implements_interface' do
      specify do
        expect(ExampleImplementation.included_modules).to include(ExampleInterface)
        expect(ExampleImplementation.singleton_class.included_modules).to include(Duckface::ImplementationMethods)
      end
    end

    describe '.check_it_implements' do
      subject(:check_it_implements) do
        ExampleImplementation.check_it_implements(ExampleInterface)
      end

      let(:check_class_implements_interface_service) do
        instance_double(Services::CheckClassImplementsInterface)
      end

      before do
        allow(Services::CheckClassImplementsInterface)
          .to receive(:new)
          .with(ExampleImplementation, ExampleInterface)
          .and_return(check_class_implements_interface_service)
      end

      specify do
        expect(check_class_implements_interface_service)
          .to receive(:perform)
          .and_return(true)
        expect(check_it_implements).to be true
      end
    end
  end
end
