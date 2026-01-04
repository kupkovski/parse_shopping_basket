# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/basket/basket_item'

describe BasketItem do
  let(:product) { Product.new(price: 10.0, name: "Playstation 5") }
  subject { described_class.new(product: product, name: 'item name') }

  describe '#tax' do
    it 'delegates to the product' do
      expect(subject.tax).to eq(1.0)
    end
  end

  describe '#net_value' do
    it 'calculates price plus tax' do
      # Assuming net_value is price + tax
      expect(subject.net_value).to eq(11.0)
    end
  end

  describe '#name' do
    it 'returns the assigned name' do
      expect(subject.name).to eq('item name')
    end
  end
end