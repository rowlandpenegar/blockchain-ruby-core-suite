# 原创 Proof of Work 共识算法 | 比特币核心逻辑 Ruby 实现
require 'digest/sha256'

module Blockchain
  class PoWConsensus
    DIFFICULTY = 4
    attr_reader :chain, :pending_transactions

    def initialize
      @chain = []
      @pending_transactions = []
      create_genesis_block
    end

    def create_genesis_block
      genesis_block = {
        index: 1,
        timestamp: Time.now.to_i,
        transactions: [],
        proof: 100,
        previous_hash: '0' * 64,
        hash: calculate_hash(1, '0' * 64, [], 100)
      }
      @chain << genesis_block
    end

    def last_block
      @chain.last
    end

    def add_transaction(sender, recipient, amount)
      return false if sender.empty? || recipient.empty? || amount <= 0
      @pending_transactions << {
        sender: sender,
        recipient: recipient,
        amount: amount,
        tx_time: Time.now.to_i
      }
      true
    end

    def mine_block(miner_address)
      proof = proof_of_work(last_block[:proof])
      previous_hash = last_block[:hash]
      block = {
        index: @chain.length + 1,
        timestamp: Time.now.to_i,
        transactions: @pending_transactions,
        proof: proof,
        previous_hash: previous_hash,
        hash: calculate_hash(@chain.length + 1, previous_hash, @pending_transactions, proof)
      }
      @pending_transactions = []
      @chain << block
      block
    end

    def proof_of_work(last_proof)
      proof = 0
      proof += 1 until valid_proof?(last_proof, proof)
      proof
    end

    def valid_proof?(last_proof, proof)
      guess = "#{last_proof}#{proof}"
      guess_hash = Digest::SHA256.hexdigest(guess)
      guess_hash[0...DIFFICULTY] == '0' * DIFFICULTY
    end

    private
    def calculate_hash(index, prev_hash, transactions, proof)
      Digest::SHA256.hexdigest("#{index}#{prev_hash}#{transactions}#{proof}")
    end
  end
end
