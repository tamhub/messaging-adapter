# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'messaging-adapter'
  s.version     = '1.0.5'
  s.date        = '2018-10-10'
  s.summary     = 'Messaging adapter for Ruby.'
  s.description = 'Makes it easy to pub/sup with many message brokers.'
  s.authors     = ['Ayyoub Jadoo @ TAM']
  s.email       = 'ayyoubjadoo@gmail.com'
  s.files       = [
    'lib/messaging_adapter.rb',
    'lib/messaging_adapter/adapters/rabbitmq_ex.rb',
    'lib/messaging_adapter/adapters/kafka.rb'
  ]
  s.homepage =
    'http://rubygems.org/gems/messaging-adapter'
  s.license = 'MIT'
  s.add_runtime_dependency('bunny', '~> 2.12')
  s.add_runtime_dependency('json', '~> 2.1')
  s.add_development_dependency('bunny', '~> 2.12')
  s.add_development_dependency('json', '~> 2.1')
  s.require_paths = ['lib']
  s.metadata = {
    documentation_uri: 'https://github.com/tamhub/messaging-adapter',
    homepage_uri: 'https://github.com/tamhub/messaging-adapter',
    source_code_uri: 'https://github.com/tamhub/messaging-adapter'
  }
end
