module Suppliers
  class Paperflies < Base
    URL_PATH = "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies"

    private
    def transform_data(json_data)
      hotel_id = json_data['hotel_id']
      destination_id = json_data['destination_id']
      name = json_data['hotel_name']
      address = json_data['location']['address']
      country = json_data['location']['country']
      details = json_data['details']
      amenities = json_data['amenities']
      images = json_data['images']
      booking_conditions = json_data['booking_conditions']

      # convert hash_map to array
      new_amenities = []
      amenities.each do |category, list_amenities|
        new_amenities += list_amenities.map do |amenity|
          {
            hotel_id: hotel_id,
            name: amenity,
            category: category
          }
        end
      end if amenities

      new_images = []
      images.each do |category, list_images|
        new_images += list_images.map do |image|
          {
            hotel_id: hotel_id,
            url: image['link'],
            description: image['caption'],
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
          address: address,
          country: country,
        },
        description: details,
        amenities: new_amenities,
        images: new_images,
        booking_conditions: booking_conditions
      }
    end

    def url_path
      URL_PATH
    end
  end
end