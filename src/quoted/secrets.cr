require "yaml"

module Quoted
  class Secrets
    YAML.mapping(
      pixabay_api_key: String,
    )
  end

  def self.secrets
    @@secrets ||= Secrets.from_yaml(File.open("config/secrets/#{env.id}.yml"))
  end
end
