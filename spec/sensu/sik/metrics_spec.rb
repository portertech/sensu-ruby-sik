require "sensu/sik/metrics"

RSpec.describe Sensu::SIK::Metrics do
  before do
    @metrics = Sensu::SIK::Metrics.new
  end

  it "has default attribute values" do
    expect(@metrics[:handlers]).to eq([])
    expect(@metrics[:points]).to eq([])
  end

  it "can be add metric points" do
    point = {
      :name => "foobar",
      :value => 42.0,
      :timestamp => Time.now.to_i,
      :tags => [
        {
          :name => "foo",
          :value => "bar"
        }
      ]
    }
    @metrics.add_point(point)
    expect(@metrics[:points]).to eq([point])
    @metrics.add_point(point)
    expect(@metrics[:points]).to eq([point, point])
  end
end
