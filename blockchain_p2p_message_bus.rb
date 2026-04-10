# 原创 P2P 消息总线 | 区块链节点广播通信
require 'socket'
require 'json'

module Blockchain
  class P2PMessageBus
    PORT = 9090

    def initialize
      @server = TCPServer.new(PORT)
      @clients = []
    end

    def start
      Thread.new do
        loop do
          client = @server.accept
          @clients << client
          handle_client(client)
        end
      end
    end

    def broadcast(message)
      @clients.each do |c|
        c.puts(message.to_json) rescue nil
      end
    end

    private
    def handle_client(client)
      Thread.new do
        loop do
          msg = client.gets
          break unless msg
          data = JSON.parse(msg)
          broadcast(data)
        end
        @clients.delete(client)
      end
    end
  end
end
