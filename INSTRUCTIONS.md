# Ruby Technical challenge

As we want to provide a better experience for our users we want to represent their itinerary in the most comprehensive way possible.

We receive the reservations of our user that we know is based on SVQ as:

```
# input.txt

RESERVATION
SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10

RESERVATION
SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10

RESERVATION
SEGMENT: Flight SVQ 2023-01-05 20:40 -> BCN 22:10
SEGMENT: Flight BCN 2023-01-10 10:30 -> SVQ 11:50

RESERVATION
SEGMENT: Train SVQ 2023-02-15 09:30 -> MAD 11:00
SEGMENT: Train MAD 2023-02-17 17:00 -> SVQ 19:30

RESERVATION
SEGMENT: Hotel MAD 2023-02-15 -> 2023-02-17

RESERVATION
SEGMENT: Flight BCN 2023-03-02 15:00 -> NYC 22:45
```

But we run a command like `BASED=SVQ bundle exec ruby main.rb input.txt` want to expose and UI like this:

```
TRIP to BCN
Flight from SVQ to BCN at 2023-01-05 20:40 to 22:10
Hotel at BCN on 2023-01-05 to 2023-01-10
Flight from BCN to SVQ at 2023-01-10 10:30 to 11:50

TRIP to MAD
Train from SVQ to MAD at 2023-02-15 09:30 to 11:00
Hotel at MAD on 2023-02-15 to 2023-02-17
Train from MAD to SVQ at 2023-02-17 17:00 to 19:30

TRIP to NYC
Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10
Flight from BCN to NYC at 2023-03-02 15:00 to 22:45
```

You have to write a ruby code that gets the input from the file `input.txt` and prints the expected output.

Take into account the following aspects:

- You should implement the sort and grouping logic of the segments.
- You can assume that segments won’t overlap.
- IATAs are always three-letter capital words: SVQ, MAD, BCN, NYC
- You can use external framework or libraries if you want.
- You can attach notes explaining the solution and why certain things are included and others are left out.
- You may consider two flights to be a connection if there is less than 24 hours difference.
- The solution should be production ready.
- You should provide a solution easy to extend.

You can reply to the email you received if you have any doubt.

In order to submit your solution, create your own Github repository and send us by email when it is ready.

Thank you very much for your time and good luck!

## My questions

* What would be the expected result if the provided BASED value is other than SVQ?

There is no unique solution to this problem. Choose the best approach that you think fits the problem. What expect you to see if you are in the user's shoes?

* What should happen if the provided BASED is not an origin or destination in the input file?

Same as above, you are free to choose the best approach that you think.

* Should I assume the input file will have always the same format?

Yes, you can assume that the input file will always have the same format.

* Do I have to validate the input file?

Yes, you should validate the input file.

* If so, what would be the expected output in case it is not valid?

You are free to choose the best approach that you think better for production.

* Should I handle errors at all?

Yes, you should handle errors.

* If so, should I do it in any specific way?

As above, anything that you consider better for production.

* You expect the solution to be easy to extend. Could you give me more details about the kind of extensibility you are looking for?

This is part of the assesment, what do you think that could be the future requirements of this code? What would you do to make it easier
