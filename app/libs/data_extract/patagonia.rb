module DataExtract
  class Patagonia < Base
    URL_PATH = "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia"

    private
    def reformat_data(json_data)
      hotel_id = json_data['id']
      destination_id = json_data['destination']
      name = json_data['name']
      latitude = json_data['lat']
      longitude = json_data['lng']
      address = json_data['address']
      info = json_data['info']
      amenities = json_data['amenities']
      images = json_data['images']

      new_amenities = amenities.map do |amenity|
        {
          hotel_id: hotel_id,
          name: amenity
        }
      end if amenities

      new_images = []
      images.each do |category, list_images|
        new_images += list_images.map do |image|
          {
            hotel_id: hotel_id,
            url: image['url'],
            description: image['description'],
            category: category
          }
        end
      end if images
      {
        id: hotel_id,
        destination_id: destination_id,
        name: name,
        location: {
          hotel_id: hotel_id,
          lat: latitude,
          lng: longitude,
          address: address
        },
        description: info,
        amenities: new_amenities,
        images: new_images
      }
    end

    def url_path
      URL_PATH
    end
  end
end