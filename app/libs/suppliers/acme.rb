module Suppliers
  class Acme < Base
    URL_PATH = "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme"

    private
    def transform_data(json_data)
      hotel_id = json_data['Id']
      destination_id = json_data['DestinationId']
      name = json_data['Name']
      latitude = json_data['Latitude']
      longitude = json_data['Longitude']
      address = json_data['Address']
      city = json_data['City']
      country = json_data['Country']
      postal_code = json_data['PostalCode']
      description = json_data['Description']
      facilities = json_data['Facilities']

      new_facilities = facilities.map do |facility|
        {
          hotel_id: hotel_id,
          name: facility
        }
      end if facilities

      {
        id: hotel_id,
        destination_id: destination_id,
        name: name,
        location: {
          hotel_id: hotel_id,
          lat: latitude,
          lng: longitude,
          address: address,
          city: city,
          country: country,
          postal_code: postal_code
        },
        description: description,
        amenities: new_facilities
      }
    end

    def url_path
      URL_PATH
    end
  end
end