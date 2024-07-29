# frozen_string_literal: true

require_relative 'itinerary_parser'
require_relative 'itinerary_builder'
require_relative 'itinerary_renderer'

class Itinerary
  class ItineraryNotParsedError < StandardError; end
  class ItineraryNotBuiltError < StandardError; end

  def initialize(
    parser: ItineraryParser.new,
    builder: ItineraryBuilder.new,
    renderer: ItineraryRenderer.new
  )
    @parser = parser
    @builder = builder
    @renderer = renderer
    @parsed = false
    @built = false
  end

  def parse(filename:)
    @segments = parser.parse(filename:)
    @parsed = true
  end

  def build(origin:)
    if !parsed?
      raise ItineraryNotParsedError, 'Itinerary not parsed. You must call #parse method before calling #build.'
    end

    @itinerary = builder.build(segments: @segments, origin:)
    @built = true
  end

  def render
    if !built?
      raise ItineraryNotBuiltError, 'Itinerary not built. You must call #build method before calling #render.'
    end

    renderer.render(itinerary: @itinerary)
  end

  private

  attr_reader :parser, :builder, :renderer, :segments, :itinerary

  def parsed?
    @parsed
  end

  def built?
    @built
  end
end
