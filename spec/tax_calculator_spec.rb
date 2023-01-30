require_relative './spec_helper'
require_relative '../src/tax_calculator'

describe TaxCalculator do
  describe '#calculate' do
    let(:price) { 10 }
    subject { described_class.new(price: price, imported: imported, exempt: exempt) }

    context 'for an imported product' do
      let(:imported) { true }

      context 'for a non-exempt product' do
        let(:exempt) { false }

        it 'applies both imported and goods tax (5% + 10%)' do
          expect(subject.calculate).to eq(10 * 0.15)
        end
      end

      context 'for a exempt product' do
        let(:exempt) { true }

        it 'only appplies imported tax (5%)' do
          expect(subject.calculate).to eq(10 * 0.05)
        end
      end
    end

    context 'for an non-imported product' do
      let(:imported) { false }

      context 'for a non-exempt product' do
        let(:exempt) { false }

        it 'only applies and goods tax (10%)' do
          expect(subject.calculate).to eq(10 * 0.1)
        end
      end

      context 'for a exempt product' do
        let(:exempt) { true }
        it 'does not apply any taxes' do
          expect(subject.calculate).to eq(0)
        end
      end
    end
  end
end
