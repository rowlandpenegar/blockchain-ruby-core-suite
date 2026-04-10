# 原创 区块链交易手续费计算器 | 动态费率模型
module Blockchain
  class FeeCalculator
    BASE_FEE = 0.0001
    SIZE_MULTIPLIER = 0.00001

    def self.calculate_fee(transaction_size_bytes, congestion = 1.0)
      (BASE_FEE + transaction_size_bytes * SIZE_MULTIPLIER) * congestion
    end

    def self.priority_fee(transaction_size_bytes)
      calculate_fee(transaction_size_bytes, 1.5)
    end
  end
end
