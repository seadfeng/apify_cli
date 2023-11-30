require "rest-client"
require "json"

module Apify
  class Client

    attr_reader :token
  
    def initialize(token: Apify.token)
      @token = token
      raise ArgumentError, "Token cannot be nil" if token.nil?
    end

    def get_actors
      get_data(response: request(op: :get_actors))
    end

    def get_runs
      get_data(response: request(op: :get_runs))
    end

    # create run with actor id
    def create_run(id:)
      get_data(response: request(op: :create_run, id:))
    end

    def get_run(id:)
      get_data(response: request(op: :get_run, id:))
    end
 
    private

    def get_data(response:)
      JSON.parse(response.body.to_s)
    end

    def request(op:, **options)
      raise ArguemntError unless Apify::OPERATIONS.keys.include?(op)
      operation = OPERATIONS[op]
      id = options[:id]
      options.delete(:id)
      rest_client(url: operation.get_url(id:), method: operation.http_method, **options)
    end

    def default_headers
      {  
        user_agent: 'Apify Client V2',
        authorization: "Bearer #{token}"
      }
    end

    def rest_client( opts = {} ) 
      opts.merge!(headers: default_headers, max_redirects: 0, verify_ssl: false, timeout: 5)   
      begin
        RestClient::Request.execute(opts)
      rescue RestClient::ExceptionWithResponse  => e
          case e.http_code
          when 401
            e.response
          when 301, 302, 307
            e.response.follow_redirection
          else 
            raise
          end
      end
    end
  end
end