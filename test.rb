# frozen_string_literal: true

require './lib/messaging_adapter.rb'

ENV['MessageBroker_Host'] = 'localhost'
ENV['MessageBroker_Port'] = '5672'
ENV['MessageBroker_User'] = 'guest'
ENV['MessageBroker_Pass'] = 'guest'
ENV['MessageBroker_RabbitMQ_Vhost'] = '/'

puts 'Test Started..'

# Use the broker with the default adapter
broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)

t1 = Thread.new do
  broker.publish('test', x: 2, y: 5)
  broker.publish('test', x: 29, y: 46)
  broker.publish('test_queue', { x: 34, y: 89 }, direct_to_q: true)
  broker.subscribe('test_queue') do |payload|
    puts "[x] Received message: #{payload}"
  end
end

t2 = Thread.new do
  broker.publish('test', x: 200, y: 500)
  broker.publish('test', x: 290, y: 460)
  broker.publish('test', x: 340, y: 890)
  broker.subscribe('test_queue2', block: false) do |payload|
    puts "[x] Received message[2]: #{payload}"
  end
end

t1.join
t2.join
