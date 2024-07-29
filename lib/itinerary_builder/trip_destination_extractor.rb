# frozen_string_literal: true

class ItineraryBuilder
  class TripDestinationExtractor
    def extract(segments:, origin:)
      if segments.last.destination == origin
        segments.first.destination
      else
        segments.last.destination
      end
    end
  end
end
