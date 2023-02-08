# frozen_string_literal: true

require 'pry'
require_relative './spec_helper'
require_relative '../src/input_parser'

describe InputParser do
  describe '#parse' do
    subject { described_class.new }

    context 'example #1' do
      it 'should parse the input string' do
        input = <<~INPUT
          Input 1:
          2 book at 12.49
          1 music CD at 14.99
          1 chocolate bar at 0.85"
        INPUT

        expected = <<~OUTPUT
          2 book: 24.98
          1 music CD: 16.49
          1 chocolate bar: 0.85
          Sales Taxes: 1.50
          Total: 42.32
        OUTPUT

        expect(subject.parse(input)).to eq(expected)
      end

      context 'example #2' do
        it 'should parse the input string' do
          input = <<~INPUT
            Input 2:
            1 imported box of chocolates at 10.00
            1 imported bottle of perfume at 47.50
          INPUT

          expected = <<~OUTPUT
            1 imported box of chocolates: 10.50
            1 imported bottle of perfume: 54.65
            Sales Taxes: 7.65
            Total: 65.15
          OUTPUT

          expect(subject.parse(input)).to eq(expected)
        end
      end

      context 'example #3' do
        it 'should parse the input string' do
          input = <<~INPUT
            Input 3:
            1 imported bottle of perfume at 27.99
            1 bottle of perfume at 18.99
            1 packet of headache pills at 9.75
            3 imported box of chocolates at 11.25
          INPUT

          expected = <<~OUTPUT
            1 imported bottle of perfume: 32.19
            1 bottle of perfume: 20.89
            1 packet of headache pills: 9.75
            3 imported box of chocolates: 35.55
            Sales Taxes: 7.90
            Total: 98.38
          OUTPUT

          expect(subject.parse(input)).to eq(expected)
        end
      end
    end
  end
end
