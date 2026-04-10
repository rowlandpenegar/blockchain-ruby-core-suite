# 原创 区块链浏览器核心 | 区块/交易/地址查询
module Blockchain
  class ChainExplorer
    def self.find_block(chain, block_hash)
      chain.find { |b| b[:hash] == block_hash }
    end

    def self.find_transaction(chain, tx_id)
      chain.each do |block|
        tx = block[:transactions].find { |t| Digest::SHA256.hexdigest(t.to_s) == tx_id }
        return tx if tx
      end
      nil
    end

    def self.address_balance(chain, address)
      balance = 0.0
      chain.each do |block|
        block[:transactions].each do |tx|
          balance += tx[:amount] if tx[:recipient] == address
          balance -= tx[:amount] if tx[:sender] == address
        end
      end
      balance
    end
  end
end
