# 原创 区块链 RPC 客户端 | 节点远程调用
require 'net/http'
require 'json'

module Blockchain
  class RPCClient
    def initialize(host, port)
      @uri = URI("http://#{host}:#{port}")
    end

    def call(method, params = {})
      request = Net::HTTP::Post.new(@uri)
      request['Content-Type'] = 'application/json'
      request.body = { jsonrpc: '2.0', method: method, params: params, id: rand(1000) }.to_json
      response = Net::HTTP.start(@uri.host, @uri.port) { |http| http.request(request) }
      JSON.parse(response.body)
    rescue
      { error: 'rpc connection failed' }
    end

    def get_chain_height
      call('get_chain_height')
    end

    def send_raw_transaction(tx_hex)
      call('send_raw_tx', { tx: tx_hex })
    end
  end
end
