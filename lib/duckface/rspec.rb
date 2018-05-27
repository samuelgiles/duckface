# frozen_string_literal: true

RSpec.shared_examples 'it implements' do |interface_class|
  describe "implements interface #{interface_class.name}" do
    subject(:check_it_implements) { described_class.check_it_implements(interface_class) }

    it { is_expected.to be true }
  end
end
