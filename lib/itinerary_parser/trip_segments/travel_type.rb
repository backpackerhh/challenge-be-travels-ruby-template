# frozen_string_literal: true

require_relative 'base_type'

class ItineraryParser
  module TripSegments
    class TravelType < BaseType
      def initial_datetime
        @initial_datetime ||= DateTime.parse(raw_initial_datetime)
      end

      def final_datetime
        @final_datetime ||= DateTime.parse("#{initial_datetime.to_date} #{raw_final_datetime}")
      end

      def to_s
        "#{type} from #{origin} to #{destination} at " \
          "#{initial_datetime.strftime('%Y-%m-%d %H:%M')} to #{final_datetime.strftime('%H:%M')}"
      end
    end
  end
end
