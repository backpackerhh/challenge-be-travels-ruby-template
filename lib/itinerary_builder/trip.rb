# frozen_string_literal: true

require_relative 'trip_destination_extractor'

class ItineraryBuilder
  class Trip
    attr_reader :segments, :origin

    def initialize(segments:, origin:, destination_extractor: TripDestinationExtractor.new)
      @segments = segments
      @origin = origin
      @destination_extractor = destination_extractor
    end

    def destination
      @destination ||= destination_extractor.extract(segments:, origin:)
    end

    def ==(other)
      segments == other.segments &&
        origin == other.origin &&
        destination == other.destination
    end

    private

    attr_reader :destination_extractor
  end
end
