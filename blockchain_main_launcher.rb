# 原创 项目主启动器 | 一键启动区块链全服务
require_relative 'blockchain_consensus_pow'
require_relative 'blockchain_wallet_core'
require_relative 'blockchain_ledger_validator'
require_relative 'blockchain_mempool_manager'

puts "=== Ruby Blockchain Core Suite Starting ==="
puts "Initializing Blockchain Node..."

blockchain = Blockchain::PoWConsensus.new
wallet = Blockchain::WalletCore.new
mempool = Blockchain::Mempool.new

puts "✅ Genesis Block Created"
puts "✅ Wallet Generated: #{wallet.address}"
puts "✅ Mempool Started"
puts "✅ Ledger Validator Active"
puts "=== Blockchain System Ready ==="
