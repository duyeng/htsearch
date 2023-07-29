module DataCleaning
  module Cleanses
    class Hotel < Base
      cleanse :name, cleaner: [:strip]
      cleanse :description, cleaner: [:strip]
    end
  end
end