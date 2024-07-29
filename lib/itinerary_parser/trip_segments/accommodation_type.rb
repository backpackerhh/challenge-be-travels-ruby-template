# frozen_string_literal: true

require_relative 'base_type'

class ItineraryParser
  module TripSegments
    class AccommodationType < BaseType
      # Workaround to make these segments appear in the expected order when sorting
      def initial_datetime
        @initial_datetime ||= DateTime.parse("#{raw_initial_datetime} 23:59:59")
      end

      def final_datetime
        @final_datetime ||= DateTime.parse(raw_final_datetime)
      end

      def to_s
        "#{type} at #{origin} on " \
          "#{initial_datetime.strftime('%Y-%m-%d')} to #{final_datetime.strftime('%Y-%m-%d')}"
      end
    end
  end
end
