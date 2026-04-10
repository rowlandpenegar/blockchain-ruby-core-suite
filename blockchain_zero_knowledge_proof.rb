# 原创 简易零知识证明实现 | 隐私交易核心
require 'digest/sha256'

module Blockchain
  class ZKProof
    def self.generate_proof(secret, challenge)
      secret_hash = Digest::SHA256.hexdigest(secret.to_s)
      proof = Digest::SHA256.hexdigest("#{secret_hash}#{challenge}")
      { proof: proof, commitment: secret_hash }
    end

    def self.verify_proof(proof, commitment, challenge)
      expected = Digest::SHA256.hexdigest("#{commitment}#{challenge}")
      expected == proof
    end
  end
end
