require "spec"
require "spec-kemal"
require "webmock"
require "../src/quoted"

Spec.before_each &->WebMock.reset
