# 原创 多签钱包实现 | 2/3 多签资产安全管理
module Blockchain
  class MultiSigWallet
    REQUIRED_SIGNATURES = 2
    attr_reader :owners, :transactions

    def initialize(owner1, owner2, owner3)
      @owners = [owner1, owner2, owner3].uniq
      @transactions = {}
    end

    def create_tx(from, to, amount, creator)
      return false unless @owners.include?(creator)
      tx_id = Digest::SHA256.hexdigest("#{from}#{to}#{amount}#{Time.now.to_i}")
      @transactions[tx_id] = {
        to: to, amount: amount, signatures: [creator], confirmed: false
      }
      tx_id
    end

    def sign_tx(tx_id, signer)
      return false unless @transactions.key?(tx_id) && @owners.include?(signer)
      tx = @transactions[tx_id]
      return false if tx[:signatures].include?(signer)
      tx[:signatures] << signer
      tx[:confirmed] = true if tx[:signatures].length >= REQUIRED_SIGNATURES
      true
    end
  end
end
