class ImportDataJob
  include Sidekiq::Job
  queue_as :default

  def perform(*args)
    model_name, models = JSON.parse(args[0])

    importer = DataImport::Factory.get(model_name)
    importer.execute(models)
  end
end