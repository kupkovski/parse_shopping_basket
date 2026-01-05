# frozen_string_literal: true

module Core
  module Ports
    module ReceiptPrinter
      def print(_basket)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end
    end
  end
end