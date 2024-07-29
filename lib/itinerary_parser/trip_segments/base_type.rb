# frozen_string_literal: true

require 'date'

class ItineraryParser
  module TripSegments
    class BaseType
      attr_reader :origin, :destination, :type

      def initialize(origin:, destination:, raw_initial_datetime:, raw_final_datetime:, type:)
        @origin = origin
        @destination = destination
        @raw_initial_datetime = raw_initial_datetime
        @raw_final_datetime = raw_final_datetime
        @type = type
      end

      def initial_datetime
        raise NotImplementedError, 'Define #initial_datetime method in the subclass'
      end

      def final_datetime
        raise NotImplementedError, 'Define #final_datetime method in the subclass'
      end

      def to_s
        raise NotImplementedError, 'Define #to_s method in the subclass'
      end

      def ==(other)
        origin == other.origin &&
          destination == other.destination &&
          initial_datetime == other.initial_datetime &&
          final_datetime == other.final_datetime
      end

      private

      attr_reader :raw_initial_datetime, :raw_final_datetime
    end
  end
end
