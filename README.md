# The Sensu Ruby SIK (Software Instrumentation Kit)

Worst name or the greatest?

Instrument your application with this neat library to send metric and
incident data through the Sensu Event Pipeline.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "sensu-sik"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sensu-sik

## Usage

Require the library and configure the client.

```ruby
require "sensu/sik"

@client = Sensu::SIK::Client.new(
  api_url: "http://sensu.yourdomain.com:8080",
  user: "store-app",
  password: "Secr3tP@ssw0rd!"
)
```

Create and update a Sensu Entity for the application.

```ruby
entity = Sensu::SIK::Entity.new(@client, id: "store-app")

entity.save!
```

Create Sensu Metrics.

```ruby
metrics = Sensu::SIK::Metrics.new(handlers: ["influxdb", "timescaledb"])

point = {
  name: "orders",
  value: 42,
  timestamp: Time.now.to_i,
  tags: [
    {
      name: "product",
      value: "towel"
    }
  ]
}

metrics.add_point(point)
```

Create an Event containing the application's Entity and the Sensu
Metrics. Send the Event through the Sensu Event Pipeline!

```ruby
event = Sensu::SIK::Event.new(@client, entity: entity, metrics: metrics)

event.save!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will
create a git tag for the version, push git commits and tags, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/portertech/sensu-ruby-sik.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
