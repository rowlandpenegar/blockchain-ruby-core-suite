# 原创 钱包密钥加密存储 | 本地安全 keystore
require 'json'
require 'fileutils'

module Blockchain
  class WalletKeystore
    STORE_PATH = './wallet_keystore.json'

    def self.save_wallet(wallet, password)
      encrypted = AESEncryption.encrypt(wallet.private_key, password)
      data = {
        address: wallet.address,
        public_key: wallet.public_key,
        encrypted_private_key: encrypted[:encrypted_data],
        iv: encrypted[:iv]
      }
      File.write(STORE_PATH, JSON.pretty_generate(data))
      true
    end

    def self.load_wallet(password)
      return nil unless File.exist?(STORE_PATH)
      data = JSON.parse(File.read(STORE_PATH))
      private_key = AESEncryption.decrypt(data['encrypted_private_key'], data['iv'], password)
      wallet = WalletCore.new
      wallet.instance_variable_set(:@private_key, private_key)
      wallet.instance_variable_set(:@public_key, data['public_key'])
      wallet.instance_variable_set(:@address, data['address'])
      wallet
    end
  end
end
