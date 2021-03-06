# frozen_string_literal: true

require 'byebug'
require './lib/messaging_adapter.rb'

ENV['MessageBroker_Host'] = 'localhost'
ENV['MessageBroker_Port'] = '5672'
ENV['MessageBroker_User'] = 'guest'
ENV['MessageBroker_Pass'] = 'guest'
ENV['MessageBroker_RabbitMQ_Vhost'] = '/'

puts 'Basic Test Started..'

puts MessagingAdapter::MessageBroker.available_adapters

# Use the RMQ adapter
broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)
broker.publish('test', 'msg 1')
broker.publish('test_queue', 'msg 2', direct_to_q: true)
broker.subscribe('test_queue') do |m|
  puts m
end

# Use another adapter (not implemented yet)
broker = MessagingAdapter::MessageBroker.new(:Kafka)
broker.publish('test', 'msg 1')
broker.subscribe('test')
