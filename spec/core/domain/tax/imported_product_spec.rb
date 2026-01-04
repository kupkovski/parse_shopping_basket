# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/product/imported_product'

describe ImportedProduct do
  subject { described_class.new(name: 'box of chocolates', price: 10.00) }

  it 'adds "imported" to the name' do
    expect(subject.name).to eq('imported box of chocolates')
  end

  it 'has an import tax rate of 5%' do
    expect(subject.import_tax_rate).to eq(0.05)
  end

  it 'inherits goods tax rate of 10%' do
    expect(subject.goods_tax_rate).to eq(0.1)
  end
end