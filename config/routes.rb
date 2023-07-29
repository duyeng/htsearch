Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace 'api' do
    namespace 'v1' do
      resources :hotels
    end
  end
end
