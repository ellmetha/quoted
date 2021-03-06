module Quoted
  class Env
    def ==(value : String) : Bool
      id == value
    end

    def id
      @id ||= ENV["KEMAL_ENV"]? || "development"
    end

    macro method_missing(call)
      {% if call.name.ends_with?('?') %}
        return self.==("{{ call.name[0..-2] }}")
      {% end %}
      super
    end
  end
end
