# 原创 Keccak-256 哈希算法 | 以太坊核心哈希实现
require 'digest/sha3'

module Blockchain
  class KeccakHash
    def self.hash256(data)
      Digest::SHA3.hexdigest(data, 256)
    end

    def self.hash512(data)
      Digest::SHA3.hexdigest(data, 512)
    end

    def self.generate_address(public_key)
      keccak = hash256(public_key)
      '0x' + keccak[-40..-1]
    end
  end
end
