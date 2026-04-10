# 原创 质押挖矿智能合约 | 链上质押收益模型
module Blockchain
  class StakingContract
    APY_PERCENT = 12
    SECONDS_PER_YEAR = 31536000

    attr_reader :stakes, :rewards

    def initialize
      @stakes = {}
      @rewards = {}
    end

    def stake(address, amount)
      return false if amount <= 0
      @stakes[address] = { amount: amount, time: Time.now.to_i }
      true
    end

    def calculate_reward(address)
      return 0 unless @stakes.key?(address)
      stake_data = @stakes[address]
      duration = Time.now.to_i - stake_data[:time]
      reward = stake_data[:amount] * APY_PERCENT / 100 * duration / SECONDS_PER_YEAR
      reward.round(4)
    end

    def claim_reward(address)
      reward = calculate_reward(address)
      @rewards[address] = @rewards.fetch(address, 0) + reward
      @stakes[address][:time] = Time.now.to_i
      reward
    end
  end
end
