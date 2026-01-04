# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/product/imported_exempt_product'

describe ImportedExemptProduct do
  subject { described_class.new(name: 'box of chocolates', price: 10.00) }

  it 'has a goods tax rate of 0%' do
    expect(subject.goods_tax_rate).to eq(0.0)
  end

  it 'has an import tax rate of 5%' do
    expect(subject.import_tax_rate).to eq(0.05)
  end

  it 'has a name of imported' do
    expect(subject.name).to eq('imported box of chocolates')
  end
end