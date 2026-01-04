# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/product/exempt_product'

describe ExemptProduct do
  subject { described_class.new(name: 'book', price: 12.49) }

  it 'has a goods tax rate of 0%' do
    expect(subject.goods_tax_rate).to eq(0.0)
  end

  it 'has an import tax rate of 0%' do
    expect(subject.import_tax_rate).to eq(0.0)
  end
end