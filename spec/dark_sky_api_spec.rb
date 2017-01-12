require "spec_helper"

describe DarkSkyApi do
  let(:api_key) { "yolo" }
  let(:dark_sky_api) { DarkSkyApi.new(api_key) }

  context "api key" do
    context "api key passed in" do
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

  context ".forecast" do
    let(:latitude) { "37.8267" }
    let(:longitude) { "-122.4233" }

    it "makes a forecast request", :vcr do
      response = dark_sky_api.forecast(latitude, longitude)
      expect(response.keys).to eq(
        [
          "latitude",
          "longitude",
          "timezone",
          "offset",
          "currently",
          "minutely",
          "hourly",
          "daily",
          "alerts",
          "flags"
        ]
      )
    end

    it "keeps count of requests for the day", :vcr do
      dark_sky_api.forecast(latitude, longitude)
      expect(dark_sky_api.number_of_calls_for_today).to eq(12)
    end
  end
end
