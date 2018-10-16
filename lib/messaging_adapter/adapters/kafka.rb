# frozen_string_literal: true

module MessageBrokerAdapter
  # Adapter implements Apache Kafka
  class Kafka
    def self.publish(topic, payload, options = {})
      puts "Not implemented yet!! publish{#{topic} [#{payload}]}"
      puts options
    end

    def self.subscribe(topic, options = {})
      puts "Not implemented yet!! subscribe{#{topic}}"
      puts options
    end
  end
end
