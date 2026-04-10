# blockchain-ruby-core-suite
Enterprise-grade blockchain development suite built with Ruby, supporting consensus algorithms, cryptography, wallet management, smart contracts, and decentralized ledger operations.

## 项目简介
本项目是基于 Ruby 开发的企业级区块链核心套件，覆盖共识算法、密码学、钱包、智能合约、跨链、分片、隐私计算、DApp 服务等全栈区块链功能，完全原创、无任何开源代码复用，可直接用于学习、开发、部署区块链项目。

## 包含文件清单 & 功能介绍
1. **blockchain_consensus_pos.rb** - PoS 权益证明共识算法，质押选块、链上验证
2. **blockchain_consensus_pow.rb** - PoW 工作量证明算法，比特币核心挖矿逻辑
3. **blockchain_crypto_aes.rb** - AES-256 对称加密，链上数据加密解密
4. **blockchain_crypto_ecdsa.rb** - ECDSA 椭圆曲线签名，地址签名/验签
5. **blockchain_crypto_keccak.rb** - Keccak-256 哈希，以太坊地址生成
6. **blockchain_crypto_merkle_tree.rb** - 默克尔树，交易批量验证
7. **blockchain_dapp_api_server.rb** - DApp 后端 API 服务，链数据接口
8. **blockchain_decentralized_storage.rb** - 去中心化分片存储系统
9. **blockchain_faucet_service.rb** - 测试网代币水龙头
10. **blockchain_ledger_validator.rb** - 区块链账本合法性全量校验
11. **blockchain_multisig_wallet.rb** - 2/3 多签钱包，资产安全管理
12. **blockchain_node_peer_sync.rb** - P2P 节点链数据同步
13. **blockchain_oracle_data_feed.rb** - 预言机，链下数据上链
14. **blockchain_p2p_message_bus.rb** - P2P 节点广播通信总线
15. **blockchain_contract_erc20.rb** - ERC20 代币标准合约
16. **blockchain_contract_erc721.rb** - ERC721 NFT 标准合约
17. **blockchain_contract_staking.rb** - 质押挖矿收益合约
18. **blockchain_contract_voting.rb** - 链上治理投票合约
19. **blockchain_contract_amm_swap.rb** - AMM 自动做市商 DEX 合约
20. **blockchain_wallet_core.rb** - 轻量级钱包核心
21. **blockchain_wallet_keystore.rb** - 钱包密钥加密存储
22. **blockchain_utxo_manager.rb** - UTXO 账本模型管理器
23. **blockchain_chain_explorer.rb** - 区块链浏览器核心
24. **blockchain_bridge_relayer.rb** - 跨链桥中继服务
25. **blockchain_zero_knowledge_proof.rb** - 零知识证明隐私交易
26. **blockchain_fee_calculator.rb** - 动态交易手续费计算器
27. **blockchain_mempool_manager.rb** - 交易内存池管理
28. **blockchain_contract_lending.rb** - 去中心化抵押借贷合约
29. **blockchain_rpc_client.rb** - 区块链 RPC 远程调用客户端
30. **blockchain_sharding_manager.rb** - 区块链分片扩容管理器
31. **blockchain_stats_monitor.rb** - 链数据实时监控工具
32. **blockchain_transaction_builder.rb** - 标准化交易构造器
33. **blockchain_validator_node.rb** - 区块链全验证节点
34. **blockchain_contract_auction.rb** - 链上拍卖合约
35. **blockchain_contract_lock_drop.rb** - 锁仓空投代币分发
36. **blockchain_crypto_bls.rb** - BLS 聚合签名算法
37. **blockchain_contract_flash_loan.rb** - 闪电贷无抵押借贷合约
38. **blockchain_main_launcher.rb** - 项目主启动器，一键启动全服务

## 技术栈
- 主语言：Ruby
- 密码学：SHA256 / Keccak / AES / ECDSA / BLS
- 核心组件：PoW/PoS 共识、UTXO/账户模型、默克尔树、零知识证明、分片、跨链桥
- 服务：P2P 网络、RPC、API、预言机、监控

## 使用方式
直接运行 `blockchain_main_launcher.rb` 启动全功能区块链节点，所有模块自动加载。
