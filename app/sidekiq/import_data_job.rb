class ImportDataJob
  include Sidekiq::Job
  queue_as :default

  HOTEL_UNIQUE_COLS = ['hotel_id']
  LOCATION_UNIQUE_COLS = ['hotel_id']
  IMAGE_UNIQUE_COLS = ['hotel_id', 'url']
  AMENITY_UNIQUE_COLS = ['hotel_id', 'name']

  def perform(*args)
    model_name, models = JSON.parse(args[0])

    case model_name.to_sym
    when :hotels
      models.each do |hotel|
        updated_keys = hotel.keys - HOTEL_UNIQUE_COLS
        Hotel.import [hotel], on_duplicate_key_update: updated_keys
      end
    when :locations
      models.each do |location|
        updated_keys = location.keys - LOCATION_UNIQUE_COLS
        Location.import [location], on_duplicate_key_update: updated_keys
      end
    when :images
      models.each do |image|
        updated_keys = image.keys - IMAGE_UNIQUE_COLS
        Image.import [image], on_duplicate_key_update: updated_keys
      end
    when :amenities
      models.each do |amenity|
        updated_keys = amenity.keys - AMENITY_UNIQUE_COLS
        Amenity.import [amenity], on_duplicate_key_update: updated_keys
      end
    end
  end
end