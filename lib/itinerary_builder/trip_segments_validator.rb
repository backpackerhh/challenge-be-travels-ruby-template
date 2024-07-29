# frozen_string_literal: true

class ItineraryBuilder
  class TripSegmentsValidator
    class NotValidOriginError < StandardError; end

    def validate(segments:, origin:)
      initial_segment = segments.first

      return if initial_segment.origin == origin

      raise NotValidOriginError, <<~MESSAGE.chomp
        A trip has been found with an unexpected origin: #{initial_segment.origin}.

        The expected origin was #{origin}.

        Trip:
        #{segments.map(&:to_s).join("\n")}
      MESSAGE
    end
  end
end
