# frozen_string_literal: true

RSpec.shared_examples 'it implements' do |interface_class|
  describe "implements interface #{interface_class.name}" do
    subject(:check_it_implements) { described_class.check_it_implements(interface_class) }

    specify do
      custom_error_message = 'You must use `implements_interface` to enforce checking of interface'
      expect(check_it_implements).to be(true), custom_error_message
    end
  end
end
