# 原创 UTXO 模型管理器 | 比特币账本核心模型
module Blockchain
  class UTXOManager
    attr_reader :utxos

    def initialize
      @utxos = {}
    end

    def add_utxo(tx_id, index, address, amount)
      @utxos["#{tx_id}:#{index}"] = { address: address, amount: amount }
    end

    def spend_utxo(tx_id, index)
      @utxos.delete("#{tx_id}:#{index}")
    end

    def get_balance(address)
      @utxos.values.select { |u| u[:address] == address }.sum { |u| u[:amount] }
    end
  end
end
