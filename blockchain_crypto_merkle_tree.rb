# 原创 默克尔树实现 | 区块链交易验证核心数据结构
require 'digest/sha256'

module Blockchain
  class MerkleTree
    attr_reader :root, :leaves

    def initialize(transactions)
      @leaves = transactions.map { |tx| Digest::SHA256.hexdigest(tx.to_s) }
      @root = build_tree
    end

    def build_tree
      return @leaves[0] if @leaves.size == 1
      nodes = []
      @leaves.each_slice(2) do |left, right|
        right ||= left
        nodes << Digest::SHA256.hexdigest(left + right)
      end
      @leaves = nodes
      build_tree
    end

    def valid_transaction?(tx_hash, proof, root_hash)
      current = tx_hash
      proof.each do |node|
        current = Digest::SHA256.hexdigest(current + node)
      end
      current == root_hash
    end
  end
end
