module DataCleaning
  module Cleanses
    class BaseCleanse
      include DataCleaning::Cleanse

      def initialize(attrs)
        @attrs = attrs
      end

      def clean_attributes!
        cleaners = self.class.send(:data_cleaners)
        new_attrs = @attrs.dup
        cleaners.each do |cleaner|
          cleaner.attributes.each do |attribute|
            value = @attrs[attribute.to_s]
            cleaner.cleaners.each do |cleaner_name|
              puts "Before data cleaning #{cleaner_name} #{value}"
              new_value = execute_clean_attr(cleaner_name, value)
              puts "After data cleaning #{new_value}"
              new_attrs[attribute.to_s] = new_value
            end
          end
        end
        new_attrs
      end

      private
      def execute_clean_attr(name, value)
        cleaner = DataCleaning::Cleanse.cleaner(name)
        cleaner&.call(value)
      end
    end
  end
end