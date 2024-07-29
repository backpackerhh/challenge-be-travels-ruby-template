# frozen_string_literal: true

class ItineraryRenderer
  def render(itinerary:)
    itinerary.map do |trip|
      <<~TRIP.chomp
        TRIP to #{trip.destination}
        #{trip.segments.join("\n")}
      TRIP
    end.join("\n\n")
  end
end
