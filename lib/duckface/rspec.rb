# frozen_string_literal: true

module Duckface
  module RSpec
    class CheckSessionFailureFormatter
      def initialize(check_session)
        @check_session = check_session
      end

      def message
        return ' but it does not implement any interfaces' if @check_session.null?

        ":\n#{formatted_lines}"
      end

      private

      def formatted_lines
        lines.map do |line|
          " - #{line}"
        end.join("\n")
      end

      def lines
        [not_implemented_lines, incorrect_signature_lines].flatten
      end

      def not_implemented_lines
        @check_session.methods_not_implemented.map do |method_name|
          "#{method_name} is not present"
        end
      end

      def incorrect_signature_lines
        @check_session.methods_with_incorrect_signatures.map do |method_name|
          "#{method_name} has an incorrect method signature"
        end
      end
    end
  end
end

RSpec.shared_examples 'it implements' do |interface_class|
  subject(:check_session) { described_class.check_it_implements(interface_class) }

  def formatted_message(check_session)
    formatted_check_session = Duckface::RSpec::CheckSessionFailureFormatter.new(check_session)
    "expected to correctly implement #{described_class.name}#{formatted_check_session.message}"
  end

  describe "#{interface_class} correctly" do
    specify ' ' do
      expect(check_session.successful?).to be(true), formatted_message(check_session)
    end
  end
end
