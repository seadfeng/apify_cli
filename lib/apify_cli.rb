# frozen_string_literal: true

require_relative "apify/version"
require_relative "apify/client"

module Apify
  class Error < StandardError; end
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
