module Medusa
  module Storage

    def self.Hash(*args)
      hash = Hash.new(*args)
      # add close method for compatibility with Storage::Base
      class << hash; def close; end; end
      hash
    end

    def self.PStore(*args)
      require 'medusa/storage/pstore'
      self::PStore.new(*args)
    end

    def self.TokyoCabinet(file = 'medusa.tch')
      require 'medusa/storage/tokyo_cabinet'
      self::TokyoCabinet.new(file)
    end

    def self.KyotoCabinet(file = 'medusa.kch')
      require 'medusa/storage/kyoto_cabinet'
      self::KyotoCabinet.new(file)
    end

    def self.MongoDB(mongo_db = nil, collection_name = 'pages')
      require 'medusa/storage/mongodb'
      mongo_db ||= Mongo::Connection.new.db('medusa')
      raise "First argument must be an instance of Mongo::DB" unless mongo_db.is_a?(Mongo::DB)
      self::MongoDB.new(mongo_db, collection_name)
    end

    def self.Redis(opts = {})
      require 'medusa/storage/redis'
      self::Redis.new(opts)
    end

    def self.SQLite3(file = 'medusa.db')
      require 'medusa/storage/sqlite3'
      self::SQLite3.new(file)
    end

  end
end
