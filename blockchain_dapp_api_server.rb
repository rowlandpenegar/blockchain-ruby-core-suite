# 原创 区块链 DApp 后端服务 | Ruby 轻量 API 服务
require 'sinatra'
require 'json'

set :port, 8989
set :bind, '0.0.0.0'

$blockchain = Blockchain::PoWConsensus.new

get '/api/chain' do
  content_type :json
  { chain: $blockchain.chain, length: $blockchain.chain.length }.to_json
end

post '/api/transaction/new' do
  data = JSON.parse(request.body.read)
  required = %w[sender recipient amount]
  return { status: 'error', message: 'missing fields' }.to_json unless required.all? { |f| data.key?(f) }
  $blockchain.add_transaction(data['sender'], data['recipient'], data['amount'].to_f)
  { status: 'success', message: 'transaction added' }.to_json
end

get '/api/mine' do
  block = $blockchain.mine_block('miner-ruby-node')
  { status: 'success', block: block }.to_json
end
