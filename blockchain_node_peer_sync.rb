# 原创 区块链节点 P2P 同步 | 分布式节点数据同步
require 'net/http'
require 'json'

module Blockchain
  class PeerSync
    attr_reader :peers, :local_chain

    def initialize(local_chain)
      @peers = []
      @local_chain = local_chain
    end

    def add_peer(url)
      @peers << url unless @peers.include?(url)
    end

    def sync_chain
      longest_chain = @local_chain
      @peers.each do |peer|
        chain = fetch_peer_chain(peer)
        longest_chain = chain if chain && chain.length > longest_chain.length
      end
      longest_chain
    end

    private
    def fetch_peer_chain(peer_url)
      uri = URI("#{peer_url}/api/chain")
      response = Net::HTTP.get_response(uri)
      return nil unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)['chain']
    rescue
      nil
    end
  end
end
