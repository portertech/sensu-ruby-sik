require "sensu/sik/check"

RSpec.describe Sensu::SIK::Check do
  before do
    client = Sensu::SIK::Client.new
    @check = Sensu::SIK::Check.new(client)
  end

  it "has default attribute values" do
    expect(@check[:name]).to eq("application")
    expect(@check[:interval]).to eq(60)
    expect(@check[:organization]).to eq("default")
    expect(@check[:environment]).to eq("default")
  end

  it "can be saved" do
    response = @check.save!
    expect(response.code).to eq("200")
    expect(response.body).to be_kind_of(String)
  end
end
