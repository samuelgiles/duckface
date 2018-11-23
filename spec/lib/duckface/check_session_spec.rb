# frozen_string_literal: true

require 'duckface/check_session'

module Duckface
  describe CheckSession do
    let(:check_session) { described_class.new }

    describe '#notice_not_implemented_method' do
      subject(:notice_not_implemented_method) do
        check_session.notice_not_implemented_method(method_name)
      end

      let(:method_name) { :super_cool_method }

      specify do
        notice_not_implemented_method
        expect(check_session.methods_not_implemented).to contain_exactly(:super_cool_method)
      end
    end

    describe '#notice_method_with_incorrect_signature' do
      subject(:notice_method_with_incorrect_signature) do
        check_session.notice_method_with_incorrect_signature(method_name)
      end

      let(:method_name) { :super_cool_method }

      specify do
        notice_method_with_incorrect_signature
        expect(check_session.methods_with_incorrect_signatures)
          .to contain_exactly(:super_cool_method)
      end
    end

    describe '#successful?' do
      subject(:successful?) do
        check_session.successful?
      end

      context 'when no exceptions have been noticed' do
        it { is_expected.to be true }
      end

      context 'when a not implemented error has been noticed' do
        before do
          check_session.notice_not_implemented_method(:my_method)
        end

        it { is_expected.to be false }
      end

      context 'when an incorrect signature error has been noticed' do
        before do
          check_session.notice_method_with_incorrect_signature(:my_method)
        end

        it { is_expected.to be false }
      end

      context 'when both a not implemented error and an incorrect signature error have been noticed' do
        before do
          check_session.notice_not_implemented_method(:my_method)
          check_session.notice_method_with_incorrect_signature(:my_method)
        end

        it { is_expected.to be false }
      end
    end
  end
end
