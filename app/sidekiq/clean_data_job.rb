class CleanDataJob
  include Sidekiq::Job
  queue_as :default

  def perform(*args)
    model_name, models = JSON.parse(args[0])
    DataCleaning::Cleanse.register_cleaners

    new_models = nil

    puts "#{model_name} #{models}"

    case model_name.to_sym
    when :hotels
      new_models = models.map do |model|
        cleaner = DataCleaning::Cleanses::HotelCleanse.new(model)
        cleaner.clean_attributes!
      end
    when :locations
      new_models = models.map do |model|
        cleaner = DataCleaning::Cleanses::LocationCleanse.new(model)
        cleaner.clean_attributes!
      end
    when :images
      new_models = models.map do |model|
        cleaner = DataCleaning::Cleanses::ImageCleanse.new(model)
        cleaner.clean_attributes!
      end
    when :amenities
      new_models = models.map do |model|
        cleaner = DataCleaning::Cleanses::AmenityCleanse.new(model)
        cleaner.clean_attributes!
      end
    end

    puts "#{model_name} #{new_models}"
    ImportDataJob.perform_async([model_name, new_models].to_json) if new_models
  end
end