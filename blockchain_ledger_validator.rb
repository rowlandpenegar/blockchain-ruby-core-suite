# 原创 区块链账本合法性校验工具 | 全节点数据验证
module Blockchain
  class LedgerValidator
    def self.valid_chain?(chain)
      return false if chain.empty?
      (1...chain.length).each do |i|
        current = chain[i]
        previous = chain[i-1]
        return false if current[:previous_hash] != previous[:hash]
        return false if current[:hash] != calculate_block_hash(current)
      end
      true
    end

    def self.calculate_block_hash(block)
      Digest::SHA256.hexdigest("#{block[:index]}#{block[:previous_hash]}#{block[:transactions]}#{block[:proof]}")
    end
  end
end
