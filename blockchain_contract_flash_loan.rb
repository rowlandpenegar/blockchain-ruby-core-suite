# 原创 闪电贷合约 | 去中心化无抵押借贷
module Blockchain
  class FlashLoan
    FEE = 0.05

    attr_reader :pool_balance

    def initialize(initial_balance)
      @pool_balance = initial_balance.to_f
    end

    def execute_loan(receiver, amount)
      return false if amount > @pool_balance
      pre_balance = @pool_balance
      @pool_balance -= amount
      receiver.on_flash_loan(amount)
      return false unless @pool_balance >= pre_balance + (amount * FEE / 100)
      true
    end
  end
end
