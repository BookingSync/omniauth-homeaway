require "spec_helper"
require "omniauth-homeaway"

describe OmniAuth::Strategies::HomeAway do
  before do
    OmniAuth.config.test_mode = true
  end

  let(:request) { double("Request", params: {}, cookies: {}, env: {}) }
  let(:options) { {} }

  subject do
    OmniAuth::Strategies::HomeAway.new(nil, options).tap do |strategy|
      allow(strategy).to receive(:request) { request }
    end
  end

  it_should_behave_like "an oauth2 strategy"

  describe '#client' do
    it "has the correct site" do
      expect(subject.client.site).to eq("https://ws.homeaway.com/")
    end

    it "has the correct authorization url" do
      expect(subject.client.options[:authorize_url]).to eq("/oauth/authorize")
    end

    it "has the correct token url" do
      expect(subject.client.options[:token_url]).to eq("/oauth/token")
    end
  end

  describe '#callback_path' do
    it "has the correct callback path" do
      expect(subject.callback_path).to eq("/auth/homeaway/callback")
    end
  end

  describe '#raw_info' do
    it "fetches account info from public/me" do
      allow(subject).to receive(:access_token).and_return(double)
      response = double(parsed: {
        "firstName" => "Sebastien",
        "lastName" => "Grosjean",
        "emailAddress" => "dev@bookingsync.com"
      })
      expect(subject.access_token).to receive(:get).with("/public/me").and_return(response)
      expect(subject.raw_info["firstName"]).to eq "Sebastien"
      expect(subject.raw_info["lastName"]).to eq "Grosjean"
      expect(subject.raw_info["emailAddress"]).to eq "dev@bookingsync.com"
    end
  end

  describe '#info' do
    it "fetches account info from public/me" do
      allow(subject).to receive(:access_token).and_return(double)
      response = double(parsed: {
        "firstName" => "Sebastien",
        "lastName" => "Grosjean",
        "emailAddress" => "dev@bookingsync.com"
      })
      expect(subject.access_token).to receive(:get).with("/public/me").and_return(response)
      expect(subject.info[:first_name]).to eq "Sebastien"
      expect(subject.info[:last_name]).to eq "Grosjean"
      expect(subject.info[:email_address]).to eq "dev@bookingsync.com"
    end
  end

  describe "#build_access_token" do
    it "authenticate the token request with Basic Auth" do
      expect(subject).to receive(:request).and_return(double(params: { "code" => "CODE" }))
      expect(subject.options).to receive(:client_id).and_return("CLIENT_ID")
      expect(subject.options).to receive(:client_secret).and_return("CLIENT_SECRET")

      allow(subject).to receive(:client).and_return(double)
      allow(subject.client).to receive(:auth_code).and_return(double)
      expect(subject.client.auth_code).to receive(:get_token).with("CODE",
        { headers: { 'Authorization' => "Basic Q0xJRU5UX0lEOkNMSUVOVF9TRUNSRVQ=" } })
      subject.build_access_token
    end
  end
end
