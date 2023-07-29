module Importer
  class Images
    def execute
      models.each do |image|
        updated_keys = image.keys - ['hotel_id', 'url']
        Image.import [image], on_duplicate_key_update: updated_keys
      end
    end
  end
end