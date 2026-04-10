# 原创 区块链节点监控工具 | 实时数据统计
module Blockchain
  class ChainMonitor
    def self.chain_stats(chain)
      {
        height: chain.length,
        total_transactions: chain.sum { |b| b[:transactions].length },
        avg_block_time: chain.length > 1 ? average_block_time(chain) : 0
      }
    end

    def self.average_block_time(chain)
      times = chain.map { |b| b[:timestamp] }
      diffs = (1...times.length).map { |i| times[i] - times[i-1] }
      diffs.sum / diffs.length.to_f
    end
  end
end
