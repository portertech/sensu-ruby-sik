require "sensu/sik/statsd"

RSpec.describe Sensu::SIK::StatsD do
  it "provides the shopify statsd client" do
    Sensu::SIK::StatsD.increment("orders", :tags => ["env:production", "product:towels"])
  end
end
