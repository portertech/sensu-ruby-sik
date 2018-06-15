require "sensu/sik/entity"

RSpec.describe Sensu::SIK::Client do
  before do
    client = Sensu::SIK::Client.new
    @entity = Sensu::SIK::Entity.new(client)
  end

  it "has default attribute values" do
    expect(@entity[:id]).to be_kind_of(String)
    expect(@entity[:class]).to eq("application")
    expect(@entity[:organization]).to eq("default")
    expect(@entity[:environment]).to eq("default")
  end

  it "can be saved" do
    response = @entity.save!
    expect(response.code).to eq("200")
    expect(response.body).to be_kind_of(String)
  end
end
