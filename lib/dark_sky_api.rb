require "httparty"

class DarkSkyApi
  BASE_URL = "https://api.darksky.net"

  attr_reader :api_key, :number_of_calls_for_today

  def initialize(api_key)
     @api_key = api_key
     @number_of_calls_for_today = { calls: 0, date: Date.today }
  end

  def forecast(latitude, longitude, options = {})
    response = HTTParty.get("#{BASE_URL}/forecast/#{@api_key}/#{latitude},#{longitude}").tap do |response|
      new_number_of_calls = response.headers.fetch("x-forecast-api-calls").to_i
      update_number_of_calls(new_number_of_calls)
    end
    print @number_of_calls_for_today
    print response.parsed_response if response.code == 200
  end

  private

  def update_number_of_calls(new_number_of_calls)
    if @number_of_calls_for_today[:date] < Date.today
      @number_of_calls_for_today = { calls: 0, date: Date.today }
    else
      @number_of_calls_for_today[:calls] = new_number_of_calls
    end
  end
end
