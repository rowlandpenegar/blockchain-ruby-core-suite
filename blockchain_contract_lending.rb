# 原创 去中心化借贷合约 | 链上抵押借贷模型
module Blockchain
  class LendingContract
    COLLATERAL_RATIO = 150
    INTEREST_RATE_PER_HOUR = 0.01

    attr_reader :loans

    def initialize
      @loans = {}
    end

    def borrow(borrower, collateral_amount, borrow_amount)
      required = borrow_amount * COLLATERAL_RATIO / 100
      return false unless collateral_amount >= required
      loan_id = Digest::SHA256.hexdigest("#{borrower}#{borrow_amount}#{Time.now.to_i}")
      @loans[loan_id] = {
        borrower: borrower, collateral: collateral_amount,
        borrow: borrow_amount, start_time: Time.now.to_i, active: true
      }
      loan_id
    end

    def calculate_debt(loan_id)
      loan = @loans[loan_id]
      return 0 unless loan
      hours = (Time.now.to_i - loan[:start_time]) / 3600
      loan[:borrow] * (1 + INTEREST_RATE_PER_HOUR * hours)
    end
  end
end
