require "spec_helper"
require "omniauth-homeaway"

describe OmniAuth::Strategies::HomeAway do
  before do
    OmniAuth.config.test_mode = true
  end

  let(:request) { double("Request", params: {}, cookies: {}, env: {}) }
  let(:options) { {} }

  let(:strategy) do
    OmniAuth::Strategies::HomeAway.new(nil, options).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  it_should_behave_like "an oauth2 strategy"

  describe "#client" do
    it "has the correct site" do
      expect(strategy.client.site).to eq("https://ws.homeaway.com/")
    end

    it "has the correct authorization url" do
      expect(strategy.client.options[:authorize_url]).to eq("/oauth/authorize")
    end

    it "has the correct token url" do
      expect(strategy.client.options[:token_url]).to eq("/oauth/token")
    end
  end

  describe "#callback_path" do
    it "has the correct callback path" do
      expect(strategy.callback_path).to eq("/auth/homeaway/callback")
    end
  end

  describe "#raw_info" do
    it "fetches account info from public/me" do
      allow(strategy).to receive(:access_token).and_return(double)
      response = double(parsed: {
        "firstName" => "Sebastien",
        "lastName" => "Grosjean",
        "emailAddress" => "dev@bookingsync.com"
      })
      expect(strategy.access_token).to receive(:get).with("/public/me").and_return(response)
      expect(strategy.raw_info["firstName"]).to eq "Sebastien"
      expect(strategy.raw_info["lastName"]).to eq "Grosjean"
      expect(strategy.raw_info["emailAddress"]).to eq "dev@bookingsync.com"
    end
  end

  describe "#info" do
    it "fetches account info from public/me" do
      allow(strategy).to receive(:access_token).and_return(double)
      response = double(parsed: {
        "firstName" => "Sebastien",
        "lastName" => "Grosjean",
        "emailAddress" => "dev@bookingsync.com"
      })
      expect(strategy.access_token).to receive(:get).with("/public/me").and_return(response)
      expect(strategy.info[:first_name]).to eq "Sebastien"
      expect(strategy.info[:last_name]).to eq "Grosjean"
      expect(strategy.info[:email_address]).to eq "dev@bookingsync.com"
    end
  end

  describe "#build_access_token" do
    it "authenticate the token request with Basic Auth" do
      expect(strategy).to receive(:request).and_return(double(params: { "code" => "CODE" }))
      expect(strategy.options).to receive(:client_id).and_return("CLIENT_ID")
      expect(strategy.options).to receive(:client_secret).and_return("CLIENT_SECRET")

      allow(strategy).to receive(:client).and_return(double)
      allow(strategy.client).to receive(:auth_code).and_return(double)
      expect(strategy.client.auth_code).to receive(:get_token).with("CODE",
        { headers: { "Authorization" => "Basic Q0xJRU5UX0lEOkNMSUVOVF9TRUNSRVQ=" } })
      strategy.build_access_token
    end
  end

  describe "#callback_url" do
    let(:url_base) { "https://auth.example.com" }

    before do
      allow(request).to receive(:scheme).and_return("https")
      allow(request).to receive(:url).and_return("#{url_base}/some/page?foo=bar")

      allow(strategy).to receive(:script_name).and_return("") # as not to depend on Rack env
      allow(strategy).to receive(:query_string).and_return("?foo=bar")
    end

    it "returns default callback url (omitting querystring)" do
      expect(strategy.callback_url).to eq "#{url_base}/auth/homeaway/callback"
    end

    context "with custom callback path" do
      let(:options) { { callback_path: "/auth/homeaway/done" } }

      it "returns default callback url (omitting querystring)" do
        expect(strategy.callback_url).to eq "#{url_base}/auth/homeaway/done"
      end
    end

    context "with custom callback url" do
      let(:url) { "https://auth.myapp.com/auth/homeaway/callback" }
      let(:options) { { redirect_uri: url } }

      it "returns url from redirect_uri option" do
        expect(strategy.callback_url).to eq url
      end
    end
  end
end
