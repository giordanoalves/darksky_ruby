require "spec_helper"

describe DarkSkyApi do
  context "api key" do
    let(:dark_sky_api) { DarkSkyApi.new(api_key) }

    context "api key passed in" do
      let(:api_key) { "yolo" }

      it "stores the api key" do
        expect(dark_sky_api.api_key).to eq("yolo")
      end
    end

    context "no api key passed in" do
      let(:api_key) { nil }

      it "raises an error when no api passed in" do
        expect{ dark_sky_api }.to raise_error(DarkSkyApi::MissingApiKeyError)
      end
    end
  end
end
