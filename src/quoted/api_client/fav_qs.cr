require "http/client"
require "json"

module Quoted
  module ApiClient
    class FavQs
      class UnexpectedResponseError < Exception; end

      def qotd
        get("qotd")
      end

      private ENDPOINT_HOST = "favqs.com"
      private ENDPOINT_BASE_PATH = "/api"

      private def client
        @client ||= HTTP::Client.new(ENDPOINT_HOST, tls: true)
      end

      private def forge_path(path)
        [ENDPOINT_BASE_PATH, path].join('/').squeeze('/')
      end

      private def get(path, **params)
        params = HTTP::Params.encode(params)
        response = client.get(
          forge_path(path) + "?#{params}",
          headers: HTTP::Headers{"Content-Type" => "application/json"}
        )

        process_response(response)
      end

      private def process_response(response)
        unless response.status_code == 200
          raise UnexpectedResponseError.new(
            "Unexpected response (#{response.status_code}): #{response.body}"
          )
        end

        JSON.parse(response.body)
      end
    end
  end
end
