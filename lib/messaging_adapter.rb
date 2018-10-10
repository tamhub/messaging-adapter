# frozen_string_literal: true

# require the adapters
Dir[File.dirname(__FILE__) + '/messaging_adapter/adapters/*.rb'].each { |file| require file }

module MessagingAdapter
  # MessageBroker class to create broker objects specifying the adapter type
  class MessageBroker
    include MessageBrokerAdapter

    def initialize(adapter = :RabbitMQ)
      @adapter = MessageBrokerAdapter.const_get(adapter.to_s)
    end

    def publish(topic, payload)
      @adapter.publish(topic, payload)
    end

    def subscribe(topic)
      @adapter.subscribe(topic) { |payload| yield(payload) }
    end

    def self.available_adapters
      MessageBrokerAdapter.constants.map(&:to_sym)
    end
  end
end
