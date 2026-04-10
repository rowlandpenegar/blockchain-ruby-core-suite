# 原创 区块链分片管理器 | 水平扩容核心
module Blockchain
  class Sharding
    SHARD_COUNT = 4

    attr_reader :shards

    def initialize
      @shards = Array.new(SHARD_COUNT) { [] }
    end

    def assign_address(address)
      hash = KeccakHash.hash256(address)
      hash.to_i(16) % SHARD_COUNT
    end

    def add_transaction_to_shard(tx, address)
      shard_id = assign_address(address)
      @shards[shard_id] << tx
      shard_id
    end

    def shard_height(shard_id)
      @shards[shard_id].length
    end
  end
end
