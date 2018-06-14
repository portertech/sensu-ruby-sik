require "sensu/sik/client"

RSpec.describe Sensu::SIK::Client do
  before do
    @client = Sensu::SIK::Client.new
  end

  it "has a default user" do
    expect(@client.user).to eq("admin")
  end

  it "can create a sensu entity" do
    entity = @client.create_entity
    expect(entity[:id]).to be_kind_of(String)
  end
end
