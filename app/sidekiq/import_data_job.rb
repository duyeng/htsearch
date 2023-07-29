class ImportDataJob
  include Sidekiq::Job
  queue_as :default

  HOTEL_UNIQUE_COLS = ['hotel_id']
  LOCATION_UNIQUE_COLS = ['hotel_id']
  IMAGE_UNIQUE_COLS = ['hotel_id', 'url']
  AMENITY_UNIQUE_COLS = ['hotel_id', 'name']

  def perform(*args)
    model_name, models = JSON.parse(args[0])

    importer = Importer::Factory.get(model_name)
    importer.execute(models)
  end
end