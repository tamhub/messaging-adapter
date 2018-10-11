# Messaging Adapter
Messaging adapter gem for Ruby, useful for using message brokers (RabbitMQ, Kafka,...) in any Ruby application (including Rails applications).

## Assumptions
To use this gem and apply the instructions in the example below you must have the following things done:
1. Install Ruby (version 2.4.2 or higher)

2. Install [RabbitMQ](https://www.rabbitmq.com/) by following the [instructions](https://www.rabbitmq.com/download.html) in the official site or if you know how to use [Docker](https://www.docker.com/) you can make and run your own RabbitMQ container from this [docker image](https://hub.docker.com/_/rabbitmq/).

3. Browse to the administartion portal of RabbitMQ which will be by default on `http://localhost:15672/`.

4. Create a new `exchange` to be your message router and name it `test` then create a new queue `test_queue` to be consumed then go to the exchange and bind it to the new queue so when someone publish a message to the exchange it will be directly routed to the binded queue(s) as one-to-many topology.

* If you are confused a little bit then you should read about `message brokers` and especially `RabbitMQ` which is used in the below example.

* Please note that points #3 and #4 are optional and written just to make the example mentioned below work.

## Usage
1. In your Ruby application install the gem from the `.gem` file using the terminal.
    ```bash
    $ gem install messaging-adapter-x.y.z.gem
    ```
    * Also the gem is available on RubyGems.org so you can install it directly:
        ```bash
        $ gem install messaging-adapter
        ```

2. In the application entrypoint create the broker instance with your desired adapter.
    ```ruby
    broker = broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)
    ```
    * Only RabbitMQ currently implemented, Kafka has an initialized empty adapter.

3. Use that instance in your application to publish a message `Hey there!!` to the exchange `test`.
    `broker.publish('test', 'Hey there!!')`

4. Use that instance in your application to subscribe to a topic/queue `test_queue`.
    ```ruby
    broker.subscribe('test_queue') do |payload|
        puts "[x] Received message: #{payload}"
    end
    ```

For more details please check the `test.rb` in the root of this repository.

## Usage in Rails application
1. Add the gem to the `Gemfile` like this:
    ```ruby
    gem 'messaging-adapter'
    ```

2. Run `bundle install` command in the terminal.

3. Go to the `config/application.rb` file in your application.

4. Add the following line before the `Bundler.require` call:
    ```ruby
    require "messaging_adapter"
    ```

5. Add the following code in the last of the `Application` class:
    ```ruby
    class << self
      attr_reader :msg_broker
    end
    
    config.after_initialize do
      @msg_broker = MessagingAdapter::MessageBroker.new(:RabbitMQ)
    end
    ```
    Here we declared a class variable `msg_broker` with reader accessor to be our single instance of the `MessageBroker` in the application, this will insure that the connection with the message broker (RabbitMQ for example) will be managed correctly.

6. In your controller for example if you want to publish a message you can do it by writing in your action:
    ```ruby
    RailsApp01::Application.msg_broker.publish('test', 'Hey there!!')
    ```
    Our example application named `rails-app01` so we accessed the `msg_broker` on the `Application` class in the application module `RailsApp01`.
    
## Configurations
* The follwoing are the environment variables which can be used in `.env` files to connect to the message broker (RabbitMQ or Kafka) with their default values if not provided:
    - MessageBroker_Host="localhost"
    - MessageBroker_Port="5672"
    - MessageBroker_User="guest"
    - MessageBroker_Pass="guest"
    - MessageBroker_RabbitMQ_Block="true"

Please check the `.env.example` file for more details.

* This documentation will be improved more and more in future.
