module DataImport
  class Locations
    def execute(locations)
      locations.each do |location|
        updated_keys = location.keys - unique_keys
        Location.import [location], on_duplicate_key_update: updated_keys
      end
    end

    private
    def unique_keys
      ['hotel_id']
    end
  end
end