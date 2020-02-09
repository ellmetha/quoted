require "sentry"

sentry = Sentry::ProcessRunner.new(
  display_name: "Quoted-Dev",
  build_command: "crystal build ./src/quoted.cr -o ./bin/quoted",
  run_command: "./bin/quoted",
  files: ["./src/**/*.cr", "./src/**/*.ecr"]
)
sentry.run
