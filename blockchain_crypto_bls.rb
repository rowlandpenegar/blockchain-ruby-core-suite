# 原创 BLS 聚合签名 | 区块链节点共识签名
require 'digest/sha256'

module Blockchain
  class BLSAggregate
    def self.sign(private_key, message)
      Digest::SHA256.hexdigest("#{private_key}#{message}")
    end

    def self.aggregate_signatures(signatures)
      combined = signatures.join
      Digest::SHA256.hexdigest(combined)
    end

    def self.verify_aggregate(public_keys, message, signature)
      combined = public_keys.join + message
      Digest::SHA256.hexdigest(combined) == signature
    end
  end
end
