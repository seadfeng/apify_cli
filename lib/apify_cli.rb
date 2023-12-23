# frozen_string_literal: true

require_relative "apify/version"
require_relative "apify/client"

module Apify
  class Error < StandardError; end

  Operation = Struct.new(:target_name, :http_method, :url )  do
    def origin
      "https://api.apify.com/v2"
    end

    def get_url(id: nil, **options)
      str = if id && id.is_a?(String)
        url.sub(/{{id}}/,id)
      else
        url
      end
      str = "#{origin}/#{str}"
      if options.nil? || options.empty?
        str
      else
       "#{str}?#{ options.map{|k,v| "#{k}=#{v}" }&.join('&')}"
      end
    end
  end
  
  OPERATIONS = {
    get_actors:                 Operation.new('GetActors',          'GET',    'acts'                                   ),
    get_datasets:               Operation.new('GetDatasets',        'GET',    'datasets'                               ),
    get_dataset:                Operation.new('GetDataset',         'GET',    'datasets/{{id}}'                        ),
    get_dataset_items:          Operation.new('GetDatasetItems',    'GET',    'datasets/{{id}}/items'                  ),
    get_runs:                   Operation.new('GetRuns',            'GET',    'actor-runs'                             ),
    get_run:                    Operation.new('GetRun',             'GET',    'actor-runs/{{id}}'                      ),
    create_run:                 Operation.new('CreateRun',          'POST',   'acts/{{id}}/runs'                       ),
    resurrect_run:              Operation.new('ResurrectRun',       'POST',   'actor-runs/{{id}}/resurrect'            ),
  }.freeze

  class << self
    attr_accessor :token

    def configure
      yield self
      true
    end
    alias_method :config, :configure
  end

  def symbolize_keys(hash)
    Hash[hash.map { |k, v| v.is_a?(Hash) ? [k.to_sym, symbolize_keys(v)] : [k.to_sym, v] }]
  end
end
