# frozen_string_literal: true

require 'spec_helper'
require 'duckface/parameter_pair'

module Duckface
  describe ParameterPair do
    let(:parameter_pair) { described_class.new(parameters) }

    let(:parameters) { %i[req used_parameter] }

    describe '#for_comparison' do
      subject(:for_comparison) { parameter_pair.for_comparison }

      it { is_expected.to eq %i[req used_parameter] }

      context 'when the argument name has a leading underscore' do
        let(:parameters) { %i[req _unused_parameter] }

        it { is_expected.to eq %i[req unused_parameter] }
      end
    end
  end
end
