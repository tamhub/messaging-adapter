# Messaging Adapter
Messaging adapter gem for Ruby, useful for using message brokers (RabbitMQ, Kafka,...) in any Ruby application (including Rails applications).

## Usage
1. In your Ruby application install the gem from the file using the terminal.
    ```bash
    $ gem install messaging-adapter-x.y.z.gem
    ```
    * It will be published soon to the RubyGems
2. In the application entrypoint create the broker instance with your desired adapter.
    ```ruby
    broker = broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)
    ```
    * Only RabbitMQ currently implemented, Kafka has an initialized empty adapter.
3. Use that instance in your application to publish a message.
    `broker.publish('test', 'Hey there!!')`
4. Use that instance in your application to subscribe to a topiq/queue.
    ```ruby
    broker.subscribe('test_queue') do |payload|
        puts "[x] Received message: #{payload}"
    end
    ```

For more details please check the `test.rb` in the root of this repository.

## Configurations
* The follwoing are the environment keys used to connect to the message broker (RabbitMQ or Kafka) with their default values if not provided:
    - MessageBroker_Host="localhost"
    - MessageBroker_Port="5672"
    - MessageBroker_User="guest"
    - MessageBroker_Pass="guest"

Please check the `.env.example` file for more details.
