module Importer
  class Hotels
    def execute
      models.each do |hotel|
        updated_keys = hotel.keys - ['hotel_id']
        Hotel.import [hotel], on_duplicate_key_update: updated_keys
      end
    end
  end
end