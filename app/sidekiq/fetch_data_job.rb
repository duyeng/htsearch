class FetchDataJob
  include Sidekiq::Job
  queue_as :default

  def perform(*args)
    suppliers = []
    suppliers << Suppliers::Acme.new
    suppliers << Suppliers::Paperflies.new
    suppliers << Suppliers::Patagonia.new

    hotels = []
    locations = []
    images = []
    amenities = []

    suppliers.each do |supplier|
      hotels, locations, images, amenities = [], [], [], []

      merged_objs = supplier.fetch_data
      merged_objs.each do |merged_obj|
        id = merged_obj[:id]
        dest_id = merged_obj[:destination_id]
        location = merged_obj[:location]
        images += merged_obj[:images] if merged_obj[:images]
        amenities += merged_obj[:amenities] if merged_obj[:amenities]
        locations << location.compact if location
        hotels << merged_obj.compact.except(:location, :images, :amenities, :booking_conditions)
      end if merged_objs

      CleanDataJob.perform_async([:hotels, hotels].to_json)
      CleanDataJob.perform_async([:locations, locations].to_json)
      CleanDataJob.perform_async([:images, images].to_json)
      CleanDataJob.perform_async([:amenities, amenities].to_json)
    end
  end
end
