sidekiq_config = { url: ENV['JOB_WORKER_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config

  config.on(:startup) do
    schedule_file = 'config/schedule.yml'

    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end