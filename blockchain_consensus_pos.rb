# 原创 Proof of Stake 共识算法实现 | Ruby 区块链核心
module Blockchain
  class PoSConsensus
    attr_reader :validators, :staked_balance, :chain

    def initialize
      @validators = {}
      @staked_balance = {}
      @chain = []
    end

    # 质押代币成为验证者
    def stake_validator(address, amount)
      return false if amount <= 0
      @validators[address] = true
      @staked_balance[address] = @staked_balance.fetch(address, 0) + amount
      true
    end

    # 根据质押权重选择区块生成者
    def select_block_creator
      total_stake = @staked_balance.values.sum
      return nil if total_stake.zero?

      random_point = rand(0..total_stake)
      current = 0
      @staked_balance.each do |addr, stake|
        current += stake
        return addr if current >= random_point
      end
      @staked_balance.keys.first
    end

    # 生成新区块
    def create_block(validator_addr, data)
      return nil unless @validators[validator_addr]
      index = @chain.length + 1
      prev_hash = @chain.empty? ? '0' * 64 : @chain.last[:block_hash]
      block = {
        index: index,
        validator: validator_addr,
        timestamp: Time.now.to_i,
        data: data,
        previous_hash: prev_hash,
        block_hash: generate_block_hash(index, validator_addr, prev_hash, data)
      }
      @chain << block
      block
    end

    private
    def generate_block_hash(index, validator, prev_hash, data)
      Digest::SHA256.hexdigest("#{index}#{validator}#{prev_hash}#{data}#{Time.now.to_i}")
    end
  end
end
