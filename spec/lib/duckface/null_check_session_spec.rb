# frozen_string_literal: true

require 'duckface/null_check_session'

module Duckface
  describe NullCheckSession do
    let(:null_check_session) { described_class.new }

    describe '#methods_not_implemented' do
      subject(:methods_not_implemented) { null_check_session.methods_not_implemented }

      it { is_expected.to be_empty }
    end

    describe '#methods_with_incorrect_signatures' do
      subject(:methods_with_incorrect_signatures) do
        null_check_session.methods_with_incorrect_signatures
      end

      it { is_expected.to be_empty }
    end

    describe '#successful?' do
      subject(:successful?) { null_check_session.successful? }

      it { is_expected.to be false }
    end

    describe '#null?' do
      subject(:null?) { null_check_session.null? }

      it { is_expected.to be true }
    end
  end
end
