module Quoted
  class Env
    def ==(value : String) : Bool
      env_id == value
    end

    macro method_missing(call)
      {% if call.name.ends_with?('?') %}
        return self.==("{{ call.name[0..-2] }}")
      {% end %}
      super
    end

    private def env_id
      @env_id = ENV["KEMAL_ENV"]? || "development"
    end
  end

  def self.env
    @@env ||= Env.new
  end
end
