# 原创 测试网代币水龙头服务 | 区块链开发测试工具
module Blockchain
  class Faucet
    MAX_AMOUNT = 100.0
    COOLDOWN_HOURS = 24
    attr_reader :balances, :claim_history

    def initialize
      @balances = {}
      @claim_history = {}
    end

    def claim_tokens(address)
      return { status: 'error', msg: 'cooldown active' } if on_cooldown?(address)
      @balances[address] = @balances.fetch(address, 0.0) + MAX_AMOUNT
      @claim_history[address] = Time.now.to_i
      { status: 'success', amount: MAX_AMOUNT, total: @balances[address] }
    end

    private
    def on_cooldown?(address)
      last = @claim_history[address]
      return false unless last
      Time.now.to_i - last < COOLDOWN_HOURS * 3600
    end
  end
end
