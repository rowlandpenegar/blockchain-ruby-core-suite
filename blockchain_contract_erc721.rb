# 原创 ERC721 NFT 标准合约 | Ruby 实现
module Blockchain
  class ERC721NFT
    attr_reader :name, :symbol, :owners, :token_uris

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
      @owners = {}
      @token_uris = {}
      @token_counter = 0
    end

    def mint(to, uri)
      token_id = @token_counter += 1
      @owners[token_id] = to
      @token_uris[token_id] = uri
      token_id
    end

    def transfer(from, to, token_id)
      return false unless @owners[token_id] == from
      @owners[token_id] = to
      true
    end

    def owner_of(token_id)
      @owners[token_id]
    end
  end
end
