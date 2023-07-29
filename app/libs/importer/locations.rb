module Importer
  class Locations
    def execute
      models.each do |location|
        updated_keys = location.keys - ['hotel_id']
        Location.import [location], on_duplicate_key_update: updated_keys
      end
    end
  end
end