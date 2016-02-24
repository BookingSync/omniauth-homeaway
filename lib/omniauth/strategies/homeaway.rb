require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class HomeAway < OmniAuth::Strategies::OAuth2
      option :name, "homeaway"

      option :client_options, site: "https://ws.homeaway.com/"

      uid { raw_info["emailAddress"] }

      info do
        {
          first_name: raw_info["firstName"],
          last_name: raw_info["lastName"],
          email_address: raw_info["emailAddress"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/public/me").parsed
      end

      def build_access_token
        verifier = request.params["code"]

        auth = "Basic #{Base64.strict_encode64("#{options.client_id}:#{options.client_secret}")}"

        client.auth_code.get_token(verifier, { headers: { 'Authorization' => auth } })
      end
    end
  end
end

OmniAuth.config.add_camelization "homeaway", "HomeAway"
