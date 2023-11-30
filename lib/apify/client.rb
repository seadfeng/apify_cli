require "rest-client"
require "json"

module Apify
  class Client

    attr_reader :token
  
    def initialize(token: Apify.token)
      @token = token
    end
 
    private 
    def default_headers
      {  
        user_agent: 'Apify Client V2',
        authorization: "Bearer #{token}"
      }
    end

    def rest_client( opts = {} ) 
      opts.merge!(headers: default_headers)   
      begin
        @response = RestClient::Request.execute(opts)
      rescue RestClient::ExceptionWithResponse  => e
          case e.http_code
          when 404
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