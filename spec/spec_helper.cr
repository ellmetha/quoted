require "spec"
require "spec-kemal"
require "webmock"

require "../src/quoted"

require "./support/*"

Spec.before_each &->WebMock.reset
