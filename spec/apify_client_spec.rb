RSpec.describe Apify::Client do
  
  
  it "raises an exception when token is nil" do
    expect { Apify::Client.new }.to raise_error(ArgumentError, /Token cannot be nil/)
  end

  # it "Get 401 Test error" do
  #   client = Apify::Client.new(token: 'test')
  #   res = client.get_actors
  #   expect(res['error'].is_a?(Hash)).to eq(true)
  # end

  client = Apify::Client.new(token: ENV['APIFY_TOKEN'])
  actors = client.get_actors
  runs = client.get_runs

  it "Get Actors" do
    expect(actors['data']['total'].is_a?(Numeric)).to eq(true)
  end

  it "Get Runs" do
    expect(runs['data']['total'].is_a?(Numeric)).to eq(true)
  end

  unless runs.nil? && runs['data']['items'].zero?
    it "Get Run" do
      first_run = runs['data']['items']&.first
      run = client.get_run(id: first_run['id'])
      expect(run['data']['status'].is_a?(String)).to eq(true)
    end
  end
end