# frozen_string_literal: true

require_relative 'trip_segment_factory'

class ItineraryParser
  class TripSegmentEntryParser
    class InvalidSegmentError < StandardError; end

    ENTRY_STARTING_TEXT = 'SEGMENT:'
    SEGMENT_REGEXP = /
      \A
      #{ENTRY_STARTING_TEXT}
      \s                                                         # white space char
      (?<type>\w+)                                               # segment type
      \s                                                         # white space char
      (?<origin>[A-Z]{3})                                        # origin
      \s                                                         # white space char
      (?<raw_initial_datetime>\d{4}-\d{2}-\d{2}(\s\d{2}:\d{2})?) # initial datetime, optional time
      \s                                                         # white space char
      ->                                                         # separator
      \s                                                         # white space char
      ((?<destination>[A-Z]{3})\s)?                              # destination, optional
      (?<raw_final_datetime>(\d{4}-\d{2}-\d{2}|\d{2}:\d{2}))     # final datetime, only date or only time
    /x

    def parse(entry:)
      matched_data = SEGMENT_REGEXP.match(entry)

      if matched_data.nil?
        raise InvalidSegmentError, <<~MESSAGE
          Found an invalid segment:
          #{entry.chomp}

          The segment is expected to match following regular expression:
          #{SEGMENT_REGEXP}
        MESSAGE
      end

      data = matched_data.named_captures.transform_keys(&:to_sym)

      TripSegmentFactory.for(data)
    end
  end
end
