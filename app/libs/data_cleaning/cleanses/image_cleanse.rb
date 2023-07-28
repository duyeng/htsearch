module DataCleaning
  module Cleanses
    class ImageCleanse < BaseCleanse
      cleanse :url, cleaner: []
      cleanse :description, cleaner: [:strip, :downcase]
      cleanse :category, cleaner: [:strip, :downcase]
    end
  end
end