# frozen_string_literal: true

require_relative 'itinerary_parser/file_validator'
require_relative 'itinerary_parser/file_entry_parser'

class ItineraryParser
  class FileNotFoundError < StandardError; end

  def initialize(file_validator: FileValidator.new, entry_parser: FileEntryParser.new)
    @file_validator = file_validator
    @entry_parser = entry_parser
  end

  def parse(filename:)
    entries = File.readlines(filename.to_s)

    file_validator.validate(entries:)

    entries.map { |entry| entry_parser.parse(entry:) }.compact
  rescue Errno::ENOENT
    raise FileNotFoundError, "File not found: #{filename}"
  end

  private

  attr_reader :file_validator, :entry_parser
end
