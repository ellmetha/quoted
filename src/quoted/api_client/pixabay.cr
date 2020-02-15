require "http/client"
require "json"

module Quoted
  module ApiClient
    class Pixabay
      class UnexpectedResponseError < Exception; end

      def search(**params)
        get("/", **params)
      end

      private ENDPOINT_HOST = "pixabay.com"
      private ENDPOINT_BASE_PATH = "/api"

      private def client
        @client ||= HTTP::Client.new(ENDPOINT_HOST, tls: true)
      end

      private def forge_path(path)
        [ENDPOINT_BASE_PATH, path].join('/').squeeze('/')
      end

      private def get(path, **params)
        params = HTTP::Params.encode(
          params.to_h.transform_keys(&.to_s).transform_values(&.to_s).merge(
            { "key" => Quoted.secrets.pixabay_api_key }
          )
        )

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
