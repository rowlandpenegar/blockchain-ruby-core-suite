# 原创 椭圆曲线数字签名算法 | 区块链地址签名/验签核心
require 'openssl'
require 'digest/sha256'

module Blockchain
  class ECDSA
    CURVE = 'secp256k1'

    def self.generate_key_pair
      key = OpenSSL::PKey::EC.new(CURVE)
      key.generate_key!
      public_key = key.public_key.to_bn.to_s(16)
      private_key = key.private_key.to_s(16)
      { private_key: private_key, public_key: public_key }
    end

    def self.sign_data(private_key_hex, data)
      key = OpenSSL::PKey::EC.new(CURVE)
      key.private_key = OpenSSL::BN.new(private_key_hex, 16)
      digest = Digest::SHA256.digest(data)
      signature = key.dsa_sign(digest)
      Base64.encode64(signature)
    end

    def self.verify_signature(public_key_hex, data, signature_base64)
      key = OpenSSL::PKey::EC.new(CURVE)
      key.public_key = OpenSSL::PKey::EC::Point.new(OpenSSL::PKey::EC.new(CURVE).group, OpenSSL::BN.new(public_key_hex, 16))
      digest = Digest::SHA256.digest(data)
      signature = Base64.decode64(signature_base64)
      key.dsa_verify(digest, signature)
    end
  end
end
