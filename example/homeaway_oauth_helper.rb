require "sinatra"
require "json"
require "omniauth-homeaway"

use Rack::Session::Cookie

# The *state* is ignored as HomeAway OAuth2 provider is currently not supporting it.
use OmniAuth::Builder do
  provider :homeaway, ENV['HOMEAWAY_CLIENT_ID'], ENV['HOMEAWAY_CLIENT_SECRET'], {
    provider_ignores_state: true
  }
end

get "/" do
  <<-HTML
<html>
  <head>
    <style>
      body {
        text-align: center;
      }

      a {
        display: inline-block;
        padding: 10px 20px;
        font-size: 16px;
        color: #fff;
        background-color: #1B57AA;
        text-decoration: none;
        border-radius: 4px;
        margin: 100px auto 0;
      }

      a:hover {
        background-color: #2b88dc;
      }
    </style>
  </head>
  <body>
    <p><a href="/auth/homeaway">Sign in with HomeAway</a></p>
  </body>
</html>
HTML
end

get "/auth/:provider/callback" do
  request.env["omniauth.auth"].to_hash.to_json
end

get "/auth/failure" do
  content_type "text/plain"
  params[:message]
end
