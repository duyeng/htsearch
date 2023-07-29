module DataImport
  class Images
    def execute(images)
      images.each do |image|
        updated_keys = image.keys - unique_keys
        Image.import [image], on_duplicate_key_update: updated_keys
      end
    end

    private
    def unique_keys
      ['hotel_id', 'url']
    end
  end
end