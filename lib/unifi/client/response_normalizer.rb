# frozen_string_literal: true

module Unifi
  class Client
    require_relative 'response_normalizer'
    module ResponseNormalizer
      private

      def normalize_unifi_response(response)
        parsed = response.parsed_response

        return parsed if parsed.is_a?(Hash)

        if response.code.to_i >= 500
          return {
            'errorCode' => response.code,
            'message'   => "UniFi API error (HTTP #{response.code})"
          }
        end

        {
          'errorCode' => -1,
          'message'   => 'Unexpected UniFi API response'
        }
      end
    end
  end
end
