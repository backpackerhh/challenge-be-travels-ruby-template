# frozen_string_literal: true

class ItineraryParser
  class FileValidator
    class FileNotValidError < StandardError; end

    def validate(entries:)
      invalid_entries = entries.reject do |e|
        e.start_with?(ReservationEntryParser::ENTRY_STARTING_TEXT) ||
          e.start_with?(TripSegmentEntryParser::ENTRY_STARTING_TEXT) ||
          e.chomp.empty?
      end

      return if invalid_entries.empty?

      raise FileNotValidError, <<~MESSAGE.chomp
        File not valid.

        It should only contain following lines:
        * Lines starting with RESERVATION to group segments.
        * Lines starting with SEGMENT with details about a segment.
        * Empty lines to separate reservations.

        Example:
        ---
        RESERVATION
        SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10

        RESERVATION
        SEGMENT: Flight SVQ 2023-01-05 20:40 -> BCN 22:10
        SEGMENT: Flight BCN 2023-01-10 10:30 -> SVQ 11:50
        ---

        Invalid entries:
        ---
        #{invalid_entries.map(&:chomp).join("\n")}
        ---
      MESSAGE
    end
  end
end
