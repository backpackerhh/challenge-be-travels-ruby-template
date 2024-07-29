# Ruby Technical challenge

## Up and running

The latest Ruby version at the moment of writing is used (3.3.2). If necessary, the version used can be changed in `.ruby-version` file.

Note that at least Ruby 3.1 is required, as the shorthand hash syntax is used in the code.

Install dependencies:

```bash
$ bundle install
```

Run script:

```bash
$ BASED=SVQ bundle exec ruby main.rb input.txt
```

You should see the expected output in your terminal.

## Decisions

* The main script follows an approach similar to Python scripts, with a conditional call to `#init` method, that allows to easily test that logic.
* An itinerary object is the entry point to all the functionality.
* The logic to display the information as requested is separated in 3 steps:
  1. The itinerary is **parsed** using the filename provided from the command line.
     - The general structure of the input file is validated, checking that each line has expected format. It is a quite simple validation, with room for a more thorough validation if needed.
     - In case some errors are found, a useful error message is included with details about the expected format, an example and the entries that are not valid.
     - Once each line has been validated, they are individually parsed.
     - A file entry parser is the role player used to check the kind of entry (segment or any other), allowing to apply "Tell, don't ask" in the parser. [Highly inspired by Sandi Metz.](https://www.youtube.com/watch?v=29MAL8pJImQ)
     - Note that is necessary to discard all entries that are not trip segments from the parser.
     - Those entries that are trip segments are validated using a regular expression. Right now, the format for each segment type is similar enough so reusing that regular expression is possible.
     - A factory object builds an instance of each segment according to its type, allowing to easily extend the code with new segment types (OCP).
     - Use inheritance to define the common behavior for all segment types.
     - Existing segment types are *accommodation* (Hotel) and *travel* (Flight, Train).
     - The city where an accommodation is placed in considered the origin of the corresponding trip segment, while its destination will be `nil`.
  2. The itinerary is **built** using the origin provided with `BASED` environment variable.
     - Segments parsed in previous step are then sorted by initial datetime.
     - When sorting all segments, accommodation segments use a workaround to appear in the expected order.
     - After that, segments are grouped where the only criteria is if there is a difference of 1 day between the end of one segment and the beginning of the next.
     - Then, every group of segments is validated. Right now, the only existing validation ensures the origin of the first segment is the same origin specified by the user with `BASED` environment variable. An exception is raised with useful information if they do not match.
     - Every valid group of segments is considered a trip.
     - The destination of each trip is extracted from the segments and based on the origin.
  3. The itinerary is **rendered**.
     - The itinerary built in previous step is simply displayed to the user in the command line with the expected format.
* The order of those steps is important, so a guard clause is added at the beginning of each one to validate that the previous step has been called.
* Any exception raised is captured and a useful error message is displayed to the user. The only exception that has a specific error message is the one raised when `BASED` environment variable is not provided. The backtrace is included to help debugging the code.
* RSpec is used for testing and RuboCop for linting.
* The use of `unless` is avoided in this code because it adds a cognitive load in most cases.
