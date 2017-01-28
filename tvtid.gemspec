# encoding: utf-8

require File.dirname(__FILE__) + '/library/tvtid/version'

Gem::Specification.new do |spec|
  spec.name     = "tvtid"
  spec.version  = TVTid::Version
  spec.summary  = "Client library for tvtid.tv2.dk"

  spec.homepage = "https://github.com/mkroman/tvtid"
  spec.license  = "MIT"
  spec.author   = "Mikkel Kroman"
  spec.email    = "mk@uplink.io"
  spec.files    = Dir["library/**/*.rb", "README.md", "LICENSE", ".yardopts"]

  spec.add_runtime_dependency 'multi_json', '~> 1.12'
  spec.add_runtime_dependency 'lrucache', '~> 0.1.4'
  spec.add_runtime_dependency 'oj', '~> 2.18'

  spec.require_path = "library"
  spec.required_ruby_version = ">= 2.2"
end

# vim: set syntax=ruby:
