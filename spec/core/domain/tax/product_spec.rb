# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/product/product'

describe Product do
  subject { described_class.new(name: 'music CD', price: 14.99) }

  it 'has a name' do
    expect(subject.name).to eq('music CD')
  end

  it 'has a price' do
    expect(subject.price).to eq(14.99)
  end

  it 'has a goods tax rate of 10%' do
    expect(subject.goods_tax_rate).to eq(0.1)
  end

  it 'has an import tax rate of 0%' do
    expect(subject.import_tax_rate).to eq(0.0)
  end

  describe '#tax' do
    it 'calculates tax correctly' do
      expect(subject.tax).to eq(1.50)
    end
  end

  describe '#net_price' do
    it 'calculates net price correctly' do
      expect(subject.net_price).to eq(16.49)
    end
  end
end