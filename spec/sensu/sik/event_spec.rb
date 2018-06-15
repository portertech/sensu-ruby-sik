require "sensu/sik/event"

RSpec.describe Sensu::SIK::Event do
  before do
    client = Sensu::SIK::Client.new
    @entity = Sensu::SIK::Entity.new(client)
    @entity.save
    @check = Sensu::SIK::Check.new(client)
    @metrics = Sensu::SIK::Metrics.new
    @event = Sensu::SIK::Event.new(client)
  end

  it "has default attribute values" do
    expect(@event[:timestamp]).to be_kind_of(Integer)
  end

  it "can be saved" do
    @event[:entity] = @entity
    @event[:metrics] = @metrics
    # POST /events still requires a check :(
    # response = @event.save!
    # expect(response.code).to eq("200")
    # expect(response.body).to be_kind_of(String)
    @event[:check] = @check
    response = @event.save!
    expect(response.code).to eq("200")
    expect(response.body).to be_kind_of(String)
  end
end
