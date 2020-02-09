module Quoted
  SETTINGS = YAML.parse(File.open("config/settings/#{[ENV["KEMAL_ENV"]? || "development"]}.yml"))
end
