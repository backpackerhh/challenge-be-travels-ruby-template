# frozen_string_literal: true

Dir.glob('./lib/itinerary_parser/trip_segments/*.rb').each { |file| require file }

class ItineraryParser
  class TripSegmentFactory
    class NotSupportedTripSegmentTypeError < StandardError; end

    def self.for(data)
      TripSegments.const_get(data.fetch(:type)).new(**data)
    rescue NameError
      raise NotSupportedTripSegmentTypeError, "#{data.fetch(:type)} is an unsupported segment type"
    end
  end
end
