# frozen_string_literal: true

require_relative 'lib/itinerary'

def init
  itinerary = Itinerary.new
  itinerary.parse(filename: ARGV.shift)
  itinerary.build(origin: ENV.fetch('BASED'))

  puts itinerary.render
rescue KeyError
  puts <<~ERROR
    Error:
    Missing environment variable: BASED

    Example of usage:
    BASED=LPA bundle exec ruby main.rb input.txt
  ERROR
rescue StandardError, ScriptError => e
  puts <<~ERROR
    Error:
    #{e.message}

    Backtrace:
    #{e.backtrace.join("\n")}
  ERROR
end

if $PROGRAM_NAME == __FILE__
  init
end
