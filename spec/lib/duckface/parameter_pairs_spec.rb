# frozen_string_literal: true

require 'spec_helper'
require 'duckface/parameter_pairs'

module Duckface
  describe ParameterPairs do
    let(:parameter_pairs) { described_class.new(parameters) }

    let(:parameters) { [%i[req used_parameter], %i[req _unused_parameter]] }

    describe '#for_comparison' do
      subject(:for_comparison) { parameter_pairs.for_comparison }

      let(:used_parameter_pair) do
        instance_double(ParameterPair, for_comparison: %i[req used_parameter])
      end
      let(:unused_parameter_pair) do
        instance_double(ParameterPair, for_comparison: %i[req unused_parameter])
      end

      before do
        allow(ParameterPair)
          .to receive(:new)
          .with(%i[req used_parameter])
          .and_return(used_parameter_pair)
        allow(ParameterPair)
          .to receive(:new)
          .with(%i[req _unused_parameter])
          .and_return(unused_parameter_pair)
      end

      it { is_expected.to contain_exactly(%i[req used_parameter], %i[req unused_parameter]) }
    end
  end
end
