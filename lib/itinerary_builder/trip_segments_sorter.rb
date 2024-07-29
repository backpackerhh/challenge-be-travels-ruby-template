# frozen_string_literal: true

class ItineraryBuilder
  class TripSegmentsSorter
    def sort(segments)
      segments.sort_by(&:initial_datetime)
    end
  end
end
