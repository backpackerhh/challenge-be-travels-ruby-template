# frozen_string_literal: true

require_relative 'itinerary_builder/trip_segments_sorter'
require_relative 'itinerary_builder/trip_segments_grouper'
require_relative 'itinerary_builder/trip_segments_validator'
require_relative 'itinerary_builder/trip'

class ItineraryBuilder
  def initialize(
    segments_sorter: TripSegmentsSorter.new,
    segments_grouper: TripSegmentsGrouper.new,
    segments_validator: TripSegmentsValidator.new
  )
    @segments_sorter = segments_sorter
    @segments_grouper = segments_grouper
    @segments_validator = segments_validator
  end

  def build(segments:, origin:)
    sorted_segments = segments_sorter.sort(segments)
    grouped_segments = segments_grouper.group(sorted_segments)

    grouped_segments.map do |segments_group|
      segments_validator.validate(segments: segments_group, origin:)

      Trip.new(segments: segments_group, origin:)
    end
  end

  private

  attr_reader :segments_sorter, :segments_grouper, :segments_validator
end
