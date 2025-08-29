
# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../src/basket_item.rb'

describe BasketItem do
  let(:subject) { BasketItem.new(name: 'test', price: 10.1, tax: 5.2)}

  describe '#net_value' do
    it 'returns the sum of price and tax' do
      expect(subject.net_value).to eq(15.3) # price + tax
    end
  end
end
