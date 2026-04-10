# 原创 AMM 自动做市商合约 | 去中心化交易所核心
module Blockchain
  class AMMSwap
    FEE_PERCENT = 0.3

    attr_reader :reserve_x, :reserve_y

    def initialize(initial_x, initial_y)
      @reserve_x = initial_x.to_f
      @reserve_y = initial_y.to_f
    end

    def swap_x_to_y(amount_x)
      return 0 if amount_x <= 0
      fee = amount_x * FEE_PERCENT / 100
      input = amount_x - fee
      new_x = @reserve_x + input
      new_y = (@reserve_x * @reserve_y) / new_x
      output = @reserve_y - new_y
      @reserve_x = new_x
      @reserve_y = new_y
      output.round(4)
    end
  end
end
