# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../src/domain/product/product'
require_relative '../../../src/domain/product/imported_product'
require_relative '../../../src/domain/product/imported_exempt_product'
require_relative '../../../src/domain/tax/tax_calculator'


describe TaxCalculator do
  describe '#calculate' do
    let(:price) { 10 }
    subject { described_class.new(product: product) }

    context 'for an imported product' do
      context 'for a non-exempt product' do
        let(:product) { instance_double(ImportedProduct, price: price, goods_tax_rate: 0.1, import_tax_rate: 0.05) }

        it 'applies both imported and goods tax (5% + 10%)' do
          # TaxRounder rounds 1.5 up to 1.5
          expect(subject.calculate).to eq(1.5)
        end
      end

      context 'for a exempt product' do
        let(:product) { instance_double(ImportedExemptProduct, price: price, goods_tax_rate: 0.0, import_tax_rate: 0.05) }

        it 'only appplies imported tax (5%)' do
          # TaxRounder rounds 0.5 up to 0.5
          expect(subject.calculate).to eq(0.5)
        end
      end
    end

    context 'for an non-imported product' do
      context 'for a non-exempt product' do
        let(:product) { instance_double(Product, price: price, goods_tax_rate: 0.1, import_tax_rate: 0.0) }

        it 'only applies and goods tax (10%)' do
          # TaxRounder rounds 1.0 up to 1.0
          expect(subject.calculate).to eq(1.0)
        end
      end

      context 'for a exempt product' do
        let(:product) { instance_double(Product, price: price, goods_tax_rate: 0.0, import_tax_rate: 0.0) }

        it 'does not apply any taxes' do
          expect(subject.calculate).to eq(0)
        end
      end
    end
  end
end