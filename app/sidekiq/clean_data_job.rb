class CleanDataJob
  include Sidekiq::Job
  queue_as :default

  def perform(*args)
    model_name, models = JSON.parse(args[0])
    DataCleaning::Cleanse.register_cleaners

    new_models = nil

    puts "#{model_name} #{models}"

    cleaner = DataCleaning::Factory.get(model_name)
    new_models = cleaner.execute(models)

    puts "#{model_name} #{new_models}"
    ImportDataJob.perform_async([model_name, new_models].to_json) if new_models
  end
end