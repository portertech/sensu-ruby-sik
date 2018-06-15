# The Sensu Ruby SIK (Software Instrumentation Kit)

Worst name or the greatest?

Instrument your application with this neat library to send metric and
incident data through the Sensu Event Pipeline. This library provides
a Sensu Backend API client and Ruby classes to create and manage Sensu
resources (e.g. Entity, Event, etc.). This library also includes a
StatsD client, providing a lightweight way to track and measure
metrics in your application. The StatsD client requires a local Sensu
2.x Agent (sensu-agent) to capture the StatsD produced metrics.

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

Require the library and configure the Sensu Backend API client.

```ruby
require "sensu/sik"

@client = Sensu::SIK::Client.new(
  api_url: "http://sensu.yourdomain.com:8080",
  user: "store-app",
  password: "Secr3tP@ssw0rd!"
)
```

Create and update a Sensu Entity to represent the application.

```ruby
entity = Sensu::SIK::Entity.new(@client, id: "store-app")

entity.save!
```

Create Sensu Metrics.

```ruby
metrics = Sensu::SIK::Metrics.new(handlers: ["timescaledb"])

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

Create a Sensu Check to represent an internal application error.

```ruby
check = Sensu::SIK::Check.new(@client, name: "postgresql_connection")

check[:output] = "Unable to connect to PostgreSQL - localhost 5432"
check[:status] = 2

check[:handlers] = ["slack", "pagerduty"]
```

Create an Event containing the application's Entity and the Sensu
Check. Send the Event through the Sensu Event Pipeline!

```ruby
event = Sensu::SIK::Event.new(@client, entity: entity, check: check)

event.save!
```

Use the StatsD client!

```ruby
# You can pass a key and a ms value
Sensu::SIK::StatsD.measure("PostgreSQL.insert", 2.55)

# Or more commonly pass a block that calls your code
Sensu::SIK::StatsD.measure("PostgreSQL.insert") do
  pg.exec("INSERT INTO Orders VALUES(1,'Towel',42)")
end

StatsD.increment("orders", tags: ["env:production", "product:towels"])
```

Enable a Ruby Class for instrumentation by extending it.

```ruby
ShoppingCart.extend Sensu::SIK::StatsD::Instrument

ShoppingCart.statsd_count :ordered, "orders"
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

## Testing

The specs currently do not mock the Sensu Backend API and require a
local, fresh, running sensu-backend service. This is intentional, to
help QA the API. Webmock will eventually be used.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/portertech/sensu-ruby-sik.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
