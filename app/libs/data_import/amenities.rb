module DataImport
  class Amenities
    def execute(amenities)
      amenities.each do |amenity|
        updated_keys = amenity.keys - unique_keys
        Amenity.import [amenity], on_duplicate_key_update: updated_keys
      end
    end

    private
    def unique_keys
      ['hotel_id', 'name']
    end
  end
end