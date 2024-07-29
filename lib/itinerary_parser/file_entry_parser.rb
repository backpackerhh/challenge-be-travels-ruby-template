# frozen_string_literal: true

require_relative 'trip_segment_entry_parser'
require_relative 'reservation_entry_parser'

class ItineraryParser
  class FileEntryParser
    def parse(entry:)
      parser_klass = if entry.start_with?(TripSegmentEntryParser::ENTRY_STARTING_TEXT)
                       TripSegmentEntryParser
                     else
                       ReservationEntryParser
                     end

      parser_klass.new.parse(entry:)
    end
  end
end
