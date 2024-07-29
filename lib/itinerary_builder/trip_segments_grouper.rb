# frozen_string_literal: true

class ItineraryBuilder
  class TripSegmentsGrouper
    GAP_BETWEEN_CONNECTIONS_IN_DAYS = 1

    def group(segments)
      segments.chunk_while do |previous_segment, segment|
        segment.initial_datetime.between?(
          previous_segment.final_datetime,
          previous_segment.final_datetime + GAP_BETWEEN_CONNECTIONS_IN_DAYS
        )
      end
    end
  end
end
