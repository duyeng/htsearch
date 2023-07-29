class ExtractDataJob
  include Sidekiq::Worker
  queue_as :default

  def perform(name)
    supplier = Suppliers::Factory.get(name)
    hotels, locations, images, amenities = [], [], [], []

    merged_hotels = supplier&.extract_data
    merged_hotels.each do |hotel|
      id = hotel[:id]
      dest_id = hotel[:destination_id]
      location = hotel[:location]
      images += hotel[:images] if hotel[:images]
      amenities += hotel[:amenities] if hotel[:amenities]
      locations << location.compact if location
      hotels << hotel.compact.except(:location, :images, :amenities, :booking_conditions)
    end if merged_hotels

    CleanDataJob.perform_async([:hotels, hotels].to_json)
    CleanDataJob.perform_async([:locations, locations].to_json)
    CleanDataJob.perform_async([:images, images].to_json)
    CleanDataJob.perform_async([:amenities, amenities].to_json)
  end
end
