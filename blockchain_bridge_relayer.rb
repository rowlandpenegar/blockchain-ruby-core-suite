# 原创 跨链桥中继服务 | 多链资产转移核心
module Blockchain
  class BridgeRelayer
    attr_reader :pending_transfers

    def initialize
      @pending_transfers = []
    end

    def lock_asset(chain_a_addr, amount, target_chain, recipient)
      transfer_id = Digest::SHA256.hexdigest("#{chain_a_addr}#{amount}#{target_chain}#{recipient}#{Time.now.to_i}")
      @pending_transfers << {
        id: transfer_id,
        from: chain_a_addr, amount: amount,
        target: target_chain, to: recipient, status: :locked
      }
      transfer_id
    end

    def mint_on_target(transfer_id)
      transfer = @pending_transfers.find { |t| t[:id] == transfer_id }
      return false unless transfer
      transfer[:status] = :completed
      true
    end
  end
end
