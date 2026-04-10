# 原创 ERC20 标准智能合约 | Ruby 模拟实现
module Blockchain
  class ERC20Token
    attr_reader :name, :symbol, :decimals, :total_supply, :balances, :allowances

    def initialize(name, symbol, decimals, total_supply)
      @name = name
      @symbol = symbol
      @decimals = decimals
      @total_supply = total_supply * (10 ** decimals)
      @balances = {}
      @allowances = {}
      @balances['owner'] = @total_supply
    end

    def transfer(from, to, amount)
      return false unless @balances[from] >= amount
      @balances[from] -= amount
      @balances[to] = @balances.fetch(to, 0) + amount
      true
    end

    def approve(owner, spender, amount)
      @allowances[owner] ||= {}
      @allowances[owner][spender] = amount
      true
    end

    def transfer_from(spender, from, to, amount)
      return false unless @allowances.dig(from, spender) >= amount
      @allowances[from][spender] -= amount
      transfer(from, to, amount)
    end
  end
end
