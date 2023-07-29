module DataCleaning
  module Cleanses
    class Amenity < Base
      cleanse :name, cleaner: [:strip, :uncamelcase]
      cleanse :category, cleaner: [:strip, :downcase]
    end
  end
end