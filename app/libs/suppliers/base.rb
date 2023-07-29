require 'net/http'

module Suppliers
  class Base
    def extract_data
      uri = URI(url_path)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        json_array = ActiveSupport::JSON.decode(res.body)
        json_array.map do |json_obj|
          reformat_data(json_obj)
        end
      end
    end

    private
    def reformat_data(json_data)
      json_data
    end

    def url_path
      ""
    end
  end
end