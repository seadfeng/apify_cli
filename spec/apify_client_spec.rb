RSpec.describe Apify::Client do
  
  
  it "raises an exception when token is nil" do
    expect { Apify::Client.new }.to raise_error(ArgumentError, /Token cannot be nil/)
  end

  it "Get 401 Test error" do
    client = Apify::Client.new(token: 'test')
    res = client.get_actors
    expect(res['error'].is_a?(Hash)).to eq(true)
  end

  client = Apify::Client.new(token: ENV['APIFY_TOKEN'])
  it "Get 200 Test" do
    res = client.get_actors
    expect(res['data']['total'].is_a?(Numeric)).to eq(true)
  end
end