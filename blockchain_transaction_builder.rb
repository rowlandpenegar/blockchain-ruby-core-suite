# 原创 交易构造器 | 标准化链上交易结构
module Blockchain
  class TransactionBuilder
    def self.create_transaction(from, to, amount, fee = 0.0001)
      {
        tx_id: Digest::SHA256.hexdigest("#{from}#{to}#{amount}#{fee}#{Time.now.to_i}"),
        sender: from,
        recipient: to,
        amount: amount.to_f,
        fee: fee.to_f,
        timestamp: Time.now.to_i,
        signature: nil
      }
    end

    def self.sign_transaction(tx, wallet)
      tx[:signature] = wallet.sign_transaction(tx)
      tx
    end
  end
end
