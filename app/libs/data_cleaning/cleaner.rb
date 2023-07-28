require 'cgi'

module DataCleaning
  module Cleaner
    # Strip leading and trailing whitespace
    module Strip
      def self.call(string)
        return string unless string.is_a?(String)

        string.strip! || string
      end
    end

    # Convert to uppercase
    module Upcase
      def self.call(string)
        return string unless string.is_a?(String)

        string.upcase! || string
      end
    end

    # Convert to downcase
    module Downcase
      def self.call(string)
        return string unless string.is_a?(String)

        string.downcase! || string
      end
    end

    module UnCamelcase
      def self.call(string)
        return string unless string.is_a?(String)

        string.underscore.tr("_", " ") || string
      end
    end

    # Remove all non-word characters, including whitespace
    module RemoveNonWord
      NOT_WORDS = Regexp.compile(/\W/)

      def self.call(string)
        return string unless string.is_a?(String)

        string.gsub!(NOT_WORDS, "") || string
      end
    end

    # Remove all not printable characters
    module RemoveNonPrintable
      NOT_PRINTABLE = Regexp.compile(/[^[:print:]]/)

      def self.call(string)
        return string unless string.is_a?(String)

        # Strip invalid characters, since they are non printable
        unless string.valid_encoding?
          string = string.encode(string.encoding, invalid: :replace, undef: :replace, replace: "")
        end
        string.gsub!(NOT_PRINTABLE, '') || string
      end
    end

    # Unescape HTML Markup ( case-insensitive )
    module ReplaceHTMLMarkup
      HTML_MARKUP = Regexp.compile(/&(amp|quot|gt|lt|apos|nbsp);/in)

      def self.call(string)
        return string unless string.is_a?(String)

        string.gsub!(HTML_MARKUP) do |match|
          case match.downcase
          when "&amp;"
            "&"
          when "&quot;"
            '"'
          when "&gt;"
            ">"
          when "&lt;"
            "<"
          when "&apos;"
            "'"
          when "&nbsp;"
            " "
          else
            "&#{match};"
          end
        end || string
      end
    end

    module UnescapeURI
      def self.call(string)
        return string unless string.is_a?(String)

        CGI.unescape(string)
      end
    end

    module EscapeURI
      def self.call(string)
        return string unless string.is_a?(String)

        CGI.escape(string)
      end
    end

    # Compress multiple whitespace to a single space
    module CompressWhitespace
      WHITESPACE = Regexp.compile(/\s+/)

      def self.call(string)
        return string unless string.is_a?(String)

        string.gsub!(WHITESPACE, " ") || string
      end
    end

    # Remove Non-Digit Chars
    # Returns nil if no digit characters present
    module DigitsOnly
      DIGITS = Regexp.compile(/\D/)

      def self.call(string)
        return string unless string.is_a?(String)

        string.gsub!(DIGITS, "")
        string.length > 0 ? string : nil
      end
    end

    # Returns [Integer] after removing all non-digit characters, except '.'
    # Returns nil if no digits are present in the string.
    module StringToInteger
      NUMERIC = Regexp.compile(/[^0-9.]/)

      def self.call(string)
        return string unless string.is_a?(String)

        # Remove Non-Digit Chars, except for '.'
        string.gsub!(NUMERIC, "")
        string.length > 0 ? string.to_i : nil
      end
    end

    # Returns [Integer] after removing all non-digit characters, except '.'
    # Returns nil if no digits are present in the string.
    module StringToFloat
      NUMERIC = Regexp.compile(/[^0-9.]/)

      def self.call(string)
        return string unless string.is_a?(String)

        # Remove Non-Digit Chars, except for '.'
        string.gsub!(NUMERIC, "")
        string.length > 0 ? string.to_f : nil
      end
    end
  end
end