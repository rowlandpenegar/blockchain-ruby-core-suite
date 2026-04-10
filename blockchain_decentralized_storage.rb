# 原创 去中心化文件存储系统 | 区块链分片存储核心
require 'digest/sha256'
require 'fileutils'

module Blockchain
  class DecentralizedStorage
    STORAGE_DIR = './chain_storage'
    CHUNK_SIZE = 1024 * 256

    def initialize
      FileUtils.mkdir_p(STORAGE_DIR) unless Dir.exist?(STORAGE_DIR)
    end

    def store_file(file_path)
      return nil unless File.exist?(file_path)
      chunks = split_file(file_path)
      file_hash = Digest::SHA256.file(file_path).hexdigest
      chunks.each_with_index do |chunk, idx|
        chunk_hash = Digest::SHA256.hexdigest(chunk)
        File.write("#{STORAGE_DIR}/#{chunk_hash}.chunk", chunk)
      end
      { file_hash: file_hash, chunks_count: chunks.length }
    end

    private
    def split_file(path)
      chunks = []
      File.open(path, 'rb') do |f|
        chunks << f.read(CHUNK_SIZE) until f.eof?
      end
      chunks
    end
  end
end
