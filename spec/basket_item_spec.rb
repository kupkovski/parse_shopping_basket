
# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../src/basket/basket_item.rb'

describe BasketItem do
  let(:product) { instance_double(Product, net_price: 15.3) }
  let(:subject) { described_class.new(product: product) }

  describe '#net_value' do
    it 'delegates to product#net_price' do
      expect(subject.net_value).to eq(15.3)
      expect(product).to have_received(:net_price)
    end
  end
end
