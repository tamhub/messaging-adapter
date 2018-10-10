# frozen_string_literal: true

require './lib/messaging_adapter.rb'

puts 'Test Started..'
# Use the broker with the default adapter
broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)

t1 = Thread.new do
  broker.publish('test_queue', x: 2, y: 5)
  broker.publish('test', x: 29, y: 46)
  broker.publish('test', x: 34, y: 89)
  broker.subscribe('test_queue') do |payload|
    puts "[x] Received message: #{payload}"
  end
end

t2 = Thread.new do
  broker.publish('test', x: 200, y: 500)
  broker.publish('test', x: 290, y: 460)
  broker.publish('test', x: 340, y: 890)
  broker.subscribe('test_queue2') do |payload|
    puts "[x] Received message[2]: #{payload}"
  end
end

t1.join
t2.join

# # Use it explicitly
# broker = MessageBroker.new(:RabbitMQ)
# broker.publish('test', { x: 59, y: 29 }.to_s)
# broker.subscribe('test_queue')

# # Use another adapter
# broker = MessageBroker.new(:Kafka)
# broker.publish('test', { x: 7, y: 9 }.to_s)
# broker.subscribe('test')

# puts MessageBroker.available_adapters
