# frozen_string_literal: true

RSpec.describe Apify do
  it "has a version number" do
    expect(Apify::VERSION).not_to be nil
  end

  it "Test Get Run Url" do
    operation = Apify::OPERATIONS[:get_run]
    expect(operation.get_url(id: 'test')).to eq('https://api.apify.com/v2/actor-runs/test')
  end

  it "Test Get Runs Url" do
    operation = Apify::OPERATIONS[:get_runs]
    operation.get_url
    expect(operation.get_url).to eq('https://api.apify.com/v2/actor-runs')
  end

  it "Test Create Run Url" do
    operation = Apify::OPERATIONS[:create_run]
    expect(operation.get_url(id: 'actor-id')).to eq('https://api.apify.com/v2/acts/actor-id/runs')
  end

  it "Test Get Actors Url" do
    operation = Apify::OPERATIONS[:get_actors]
    expect(operation.get_url).to eq('https://api.apify.com/v2/acts')
  end

  it "Test Get Dataset Item Url" do
    operation = Apify::OPERATIONS[:get_dataset_items]
    expect(operation.get_url(id: 'db-id')).to eq('https://api.apify.com/v2/datasets/db-id/items')
  end

  it "Test Get Dataset Item Url with params" do
    operation = Apify::OPERATIONS[:get_dataset_items]
    expect(operation.get_url(id: 'db-id', limit: 100)).to eq('https://api.apify.com/v2/datasets/db-id/items?limit=100')
  end

end
