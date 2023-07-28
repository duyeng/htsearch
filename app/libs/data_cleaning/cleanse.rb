module DataCleaning
  module Cleanse
    DataCleaner = Struct.new(:cleaners, :attributes, :params)

    @@global_cleaners = Concurrent::Hash.new

    module ClassMethods
      def cleanse(*args)
        last       = args.last
        attributes = args.dup
        params     = last.is_a?(Hash) && last.instance_of?(Hash) ? attributes.pop.dup : {}
        cleaners   = Array(params.delete(:cleaner))
        raise(ArgumentError, "Required :cleaner parameter is missing: #{params.inspect}") unless cleaners

        cleaner = DataCleaner.new(cleaners, attributes, params)
        data_cleaners << cleaner
        cleaner
      end

      def data_cleaners
        @data_cleaners ||= Concurrent::Array.new
      end
    end

    def self.included(base)
      base.class_eval do
        extend DataCleaning::Cleanse::ClassMethods
      end
    end

    def self.register_cleaners
      @@global_cleaners[:strip] = DataCleaning::Cleaner::Strip
      @@global_cleaners[:upcase] = DataCleaning::Cleaner::Upcase
      @@global_cleaners[:downcase] = DataCleaning::Cleaner::Downcase
      @@global_cleaners[:compress_whitespace] = DataCleaning::Cleaner::CompressWhitespace
      @@global_cleaners[:remove_non_word] = DataCleaning::Cleaner::RemoveNonWord
      @@global_cleaners[:string_to_float] = DataCleaning::Cleaner::StringToFloat
      @@global_cleaners[:string_to_integer] = DataCleaning::Cleaner::StringToInteger
      @@global_cleaners[:uncamelcase] = DataCleaning::Cleaner::UnCamelcase
    end

    def self.cleaner(name)
      @@global_cleaners[name]
    end
  end
end