module DataImport
  class Hotels
    def execute(hotels)
      hotels.each do |hotel|
        updated_keys = hotel.keys - unique_keys
        Hotel.import [hotel], on_duplicate_key_update: updated_keys
      end
    end

    private
    def unique_keys
      ['hotel_id']
    end
  end
end