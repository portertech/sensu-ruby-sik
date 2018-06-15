require "sensu/sik/client"

RSpec.describe Sensu::SIK::Client do
  before do
    @client = Sensu::SIK::Client.new
  end

  it "has a default user" do
    expect(@client.user).to eq("admin")
  end
end
