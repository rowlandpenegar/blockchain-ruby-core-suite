# 原创 链上治理投票合约 | 去中心化自治组织核心
module Blockchain
  class VotingContract
    attr_reader :proposals, :votes

    def initialize
      @proposals = {}
      @votes = {}
    end

    def create_proposal(author, title, description)
      proposal_id = Digest::SHA256.hexdigest("#{author}#{title}#{Time.now.to_i}")
      @proposals[proposal_id] = {
        title: title, description: description, author: author,
        yes: 0, no: 0, active: true
      }
      proposal_id
    end

    def vote(proposal_id, voter, choice)
      return false unless @proposals.dig(proposal_id, :active)
      return false if @votes.dig(proposal_id, voter)
      @votes[proposal_id] ||= {}
      @votes[proposal_id][voter] = choice
      @proposals[proposal_id][choice.to_sym] += 1
      true
    end
  end
end
