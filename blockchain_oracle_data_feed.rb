# 原创 区块链预言机数据服务 | 链下数据上链核心
require 'net/http'
require 'json'

module Blockchain
  class OracleFeed
    def self.get_btc_price
      uri = URI('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd')
      response = Net::HTTP.get_response(uri)
      data = JSON.parse(response.body)
      data.dig('bitcoin', 'usd').to_f
    end

    def self.push_to_chain(chain, oracle_address, data)
      chain.add_transaction('oracle-feed', oracle_address, data)
    end
  end
end
