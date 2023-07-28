module DataCleaning
  module Cleanses
    class AmenityCleanse < BaseCleanse
      cleanse :name, cleaner: [:strip, :uncamelcase]
      cleanse :category, cleaner: [:strip, :downcase]
    end
  end
end