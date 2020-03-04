module Quoted
  class Cache
    def get(key)
      redis_client.get(key)
    end

    def set(key, value, timeout)
      redis_client.set(key, value)
      redis_client.expire(key, timeout)
    end

    private def redis_client
      @redis_client ||= Redis.new(database: Quoted.settings.redis_database.to_i)
    end
  end
end
