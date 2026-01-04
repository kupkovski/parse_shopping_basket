# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../src/core/domain/product/product_factory'

describe ProductFactory do
  describe '.for' do
    it 'returns Product for non-imported non-exempt' do
      expect(described_class.for(imported: false, exempt: false)).to eq(Product)
    end

    it 'returns ImportedProduct for imported non-exempt' do
      expect(described_class.for(imported: true, exempt: false)).to eq(ImportedProduct)
    end

    it 'returns ExemptProduct for non-imported exempt' do
      expect(described_class.for(imported: false, exempt: true)).to eq(ExemptProduct)
    end

    it 'returns ImportedExemptProduct for imported exempt' do
      expect(described_class.for(imported: true, exempt: true)).to eq(ImportedExemptProduct)
    end
  end
end