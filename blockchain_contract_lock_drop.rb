# 原创 锁仓空投合约 | 项目代币分发
module Blockchain
  class LockDrop
    LOCK_MONTHS = 6
    REWARD_MULTIPLIER = 1.2

    attr_reader :locks

    def initialize
      @locks = {}
    end

    def lock_tokens(user, amount)
      return false if amount <= 0
      unlock_time = Time.now.to_i + LOCK_MONTHS * 30 * 24 * 3600
      @locks[user] = { amount: amount, unlock_at: unlock_time, claimed: false }
      true
    end

    def claim(user)
      lock = @locks[user]
      return false unless lock && !lock[:claimed] && Time.now.to_i >= lock[:unlock_at]
      lock[:claimed] = true
      lock[:amount] * REWARD_MULTIPLIER
    end
  end
end
