# frozen_string_literal: true

module MessageBrokerAdapter
  # Adapter implements Apache Kafka
  class Kafka
    def self.publish(topic, payload)
      puts "Not implemented yet!! publish{#{topic} [#{payload}]}"
    end

    def self.subscribe(topic)
      puts "Not implemented yet!! subscribe{#{topic}}"
    end
  end
end
