# 原创 区块链验证节点 | 全节点验证服务
module Blockchain
  class ValidatorNode
    attr_reader :chain, :mempool, :peers

    def initialize
      @chain = Blockchain::PoWConsensus.new
      @mempool = Blockchain::Mempool.new
      @peers = Blockchain::PeerSync.new(@chain.chain)
    end

    def validate_and_add_block(block)
      return false unless Blockchain::LedgerValidator.valid_chain?(@chain.chain + [block])
      @chain.chain << block
      true
    end

    def start_mining
      loop do
        next if @mempool.transactions.empty?
        txs = @mempool.get_top_transactions(10)
        txs.each { |tx| @chain.add_transaction(tx[:sender], tx[:recipient], tx[:amount]) }
        @chain.mine_block('validator-node')
      end
    end
  end
end
