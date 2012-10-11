module I18n
  module Backend
    class CustomBit < Simple
      # Acts the same as +strftime+, but uses a localized version of the
      # format string. Takes a key from the date/time formats translations as
      # a format argument (<em>e.g.</em>, <tt>:short</tt> in <tt>:'date.formats'</tt>).
      def localize(locale, object, format = :default, options = {})
        return nil if object.nil? # Turn off whiny nil
        raise ArgumentError, "Object must be a Date, DateTime or Time object. #{object.inspect} given." unless object.respond_to?(:strftime)
        if Symbol === format
          key = format
          type = object.respond_to?(:sec) ? 'time' : 'date'
          format = I18n.t(:"#{type}.formats.#{key}", options.merge(:raise => true, :object => object, :locale => locale))
        end
        # format = resolve(locale, object, format, options)
        format = format.to_s.gsub(/%[aAbBp]/) do |match|
          case match
          when '%a' then I18n.t(:"date.abbr_day_names",                  :locale => locale, :format => format)[object.wday]
          when '%A' then I18n.t(:"date.day_names",                       :locale => locale, :format => format)[object.wday]
          when '%b' then I18n.t(:"date.abbr_month_names",                :locale => locale, :format => format)[object.mon]
          when '%B' then I18n.t(:"date.month_names",                     :locale => locale, :format => format)[object.mon]
          when '%p' then I18n.t(:"time.#{object.hour < 12 ? :am : :pm}", :locale => locale, :format => format) if object.respond_to? :hour
          end
        end
        object.strftime(format)
      end
    end
  end
end
I18n.backend = I18n::Backend::CustomBit.new
