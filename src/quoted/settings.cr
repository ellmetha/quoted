module Quoted
  class Settings
    YAML.mapping(
      redis_database: String,
      public_folder: String,
    )
  end
end
