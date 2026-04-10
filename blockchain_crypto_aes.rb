# 原创 区块链对称加密工具 | AES-256-CBC 数据加密解密
require 'openssl'
require 'base64'

module Blockchain
  class AESEncryption
    ALGORITHM = 'AES-256-CBC'

    def self.encrypt(data, secret_key)
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.encrypt
      key = Digest::SHA256.digest(secret_key)
      iv = cipher.random_iv
      cipher.key = key
      cipher.iv = iv
      encrypted = cipher.update(data) + cipher.final
      {
        iv: Base64.encode64(iv),
        encrypted_data: Base64.encode64(encrypted)
      }
    end

    def self.decrypt(encrypted_data, iv_base64, secret_key)
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.decrypt
      key = Digest::SHA256.digest(secret_key)
      cipher.key = key
      cipher.iv = Base64.decode64(iv_base64)
      decrypted = cipher.update(Base64.decode64(encrypted_data)) + cipher.final
      decrypted
    end
  end
end
