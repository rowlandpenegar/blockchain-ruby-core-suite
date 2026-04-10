# 原创 区块链轻量级钱包核心 | 地址/密钥/交易管理
module Blockchain
  class WalletCore
    attr_reader :address, :public_key, :private_key, :balance

    def initialize
      key_pair = ECDSA.generate_key_pair
      @private_key = key_pair[:private_key]
      @public_key = key_pair[:public_key]
      @address = KeccakHash.generate_address(@public_key)
      @balance = 0.0
    end

    def sign_transaction(tx_data)
      ECDSA.sign_data(@private_key, tx_data.to_s)
    end

    def update_balance(amount)
      @balance += amount
    end
  end
end
