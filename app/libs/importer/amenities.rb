module Importer
  class Amenities
    def execute
      models.each do |amenity|
        updated_keys = amenity.keys - ['hotel_id', 'name']
        Amenity.import [amenity], on_duplicate_key_update: updated_keys
      end
    end
  end
end