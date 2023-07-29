module DataCleaning
  module Cleanses
    class Base
      include DataCleaning::Cleanse

      def execute(models)
        models.map do |model|
          clean_attributes!(model)
        end
      end

      def clean_attributes!(attrs)
        cleaners = self.class.send(:data_cleaners)
        new_attrs = attrs.dup
        cleaners.each do |cleaner|
          cleaner.attributes.each do |attribute|
            value = attrs[attribute.to_s]
            cleaner.cleaners.each do |cleaner_name|
              new_value = execute_clean_attr(cleaner_name, value)
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