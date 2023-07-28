require 'net/http'

module Suppliers
  class Base
    def fetch_data
      uri = URI(url_path)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        json_array = ActiveSupport::JSON.decode(res.body)
        json_array.map do |json_obj|
          transform_data(json_obj)
        end
      end
    end

    private
    def transform_data(json_data)
      json_data
    end

    def url_path
      ""
    end
  end
end