# 原创 交易内存池管理器 | 节点待打包交易队列
module Blockchain
  class Mempool
    MAX_SIZE = 1000

    attr_reader :transactions

    def initialize
      @transactions = []
    end

    def add_transaction(tx)
      return false if @transactions.length >= MAX_SIZE
      @transactions << tx unless @transactions.include?(tx)
      @transactions.sort_by! { |t| -t[:fee] }
      true
    end

    def get_top_transactions(count)
      @transactions.shift(count)
    end

    def clear
      @transactions = []
    end
  end
end
