require "httparty"

class DarkSkyApi
  class MissingApiKeyError < RuntimeError; end;
  BASE_URL = "https://api.darksky.net"

  attr_reader :api_key, :number_of_calls_for_today

  def initialize(api_key = nil)
    raise MissingApiKeyError if api_key.nil?

    @api_key = api_key
    @number_of_calls_for_today = 0
  end

  def forecast(latitude, longitude, options = {})
    response = HTTParty.get("#{BASE_URL}/forecast/#{@api_key}/#{latitude},#{longitude}")
    update_number_of_calls(response.headers.fetch("x-forecast-api-calls").to_i)

    print @number_of_calls_for_today
    print response.parsed_response if response.code == 200
  end

  private

  def update_number_of_calls(new_number_of_calls)
    @number_of_calls_for_today = new_number_of_calls
  end
end
