require "rest-client"
require "json"

module Apify
  class Client

    attr_reader :token
  
    def initialize(token: Apify.token)
      @token = token
    end

    def get_actors
      request(op: :get_actors)
    end

    def get_runs
      request(op: :get_runs)
    end

    # create run with actor id
    def create_run(id:)
      request(op: :create_run, id:)
    end

    # Todo
    # def get_actor(id:)
    #   request(op: :get_actor, id:)
    # end

    def get_run(id:)
      request(op: :get_run, id:)
    end
 
    private
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
      puts opts
      # opts.merge!(headers: default_headers)   
      # begin
      #   @response = RestClient::Request.execute(opts)
      # rescue RestClient::ExceptionWithResponse  => e
      #     case e.http_code
      #     when 404
      #       e.response
      #     when 301, 302, 307
      #       e.response.follow_redirection
      #     else 
      #       raise
      #     end
      # end
    end
  end
end