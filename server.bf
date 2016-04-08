Preamble: some punctuation is valid Brainfuck so there is very little punctuation in these comments

This is a server that returns your useragent back to you if you sent a GET request to / and returns a 404 otherwise

Step 1: send "HTTP/1(dot)1 "
============================

You could be clever with this but I prefer to be boring

H ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
T ++++++++++++.
T .
P ----.
/ [-]+++++++++++++++++++++++++++++++++++++++++++++++.
1 ++.
dot ---.
1 +++.
space -----------------.

Step 2: is this a GET request?
==============================

Turns out that if you sum the ASCII values of each character in GET or PUT or DELETE (etc) you get different numbers (GET = 224; POST = 326; etc)
GET is the only thing that sums to 224 and with a trailing space it sums to 256
This is fabulous for us

Here's what we'll do:
* start a counter at 256 (in register 0)
* for each character:
  * subtract the ASCII value from this counter
  * if it's a space then we stop looping
* if the counter is 0 then we know it's a GET request
* if we know it's NOT a GET request then we send a 404 message

Let's make register 0 become 256:
>+++++++++++++++++[-<+++++++++++++>]<+++

Head to r1 and make sure it's nonzero so that we run the following loop at least once
>+

[
  In the context of this loop:
  * r0 = the counter (mentioned above)
  * r1 = the ASCII character for space (32)
  * r2 = the character we read

  First step is to zero out r1
  Iterations of this loop could make r1 positive OR negative so we add a bunch of numbers to it to make sure it's positive before we zero it out
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  [-]

  Next we make r1 equal to 32 (the ASCII code for space)
  ++++++++++++++++++++++++++++++++

  Read the character into r2
  >,

  Subtract the ASCII value from the counter (r0) AND subtract its value from r1
  [-<-<->>]

  Head back to r1
  This loop will stop if the character was a space (AKA r1 == 0)
  <
]

Head back to r0
<

At this point:
* if r0 == 0 then this is a GET request
* else this is any other HTTP method (POST or PUT or DELETE or whatever) and r0 is negative

The state of the registers:
* r0 is mentioned above
* everything else is 0
* pointer @ r0

Step 3: is this a request to /?
===============================

At this point we've read "(METHOD) "
The next part is the path which we hope to be "/" and nothing else

The desired result is this:
* if r1 == 0 then this is a request to /
* else this is NOT a request to / and we should 404

Let's head to r1
>

Every path starts with a / so we can read that in and ignore it
But the next character is important so we'll take a look at that
,,

Subtract 32 from this which will give us the desired result from above
--------------------------------

Let's return to r0
<

At this point:
* if r0 == 0 then this is a GET request
* if r1 == 0 then this is a request to /
* else this is a request to any other path and r1 is positive

The state of the registers:
* r0 is mentioned above
* r1 is mentioned above
* pointer @ r0

Step 4: send a 404 if we should
===============================

This is the dream code we'd love to write:

if method != 'GET' or path != '/':
  send_404

This kinda translates to:

if r0 != 0 or r1 != 0:
  send_404

Here's how we'll do this:

If r0 != 0:
[
  Set r2 to 1
  >>+
  Zero out r0
  <<[+]
]

If r1 != 0:
>[
  Increment r2
  >+<
  Zero out r1
  [-]
]

At this point:
* if r2 != 0 then we will send a 404 message
* if r2 == 0 then we will skip this
>[
  Set r2 to 0
  [-]

  "404 Not Found"
  4 ++++++++++++++++++++++++++++++++++++++++++++++++++++.
  0 ----.
  4 ++++.
    --------------------.
  N ++++++++++++++++++++++++++++++++++++++++++++++.
  o +++++++++++++++++++++++++++++++++.
  t +++++.
    ------------------------------------------------------------------------------------.
  F ++++++++++++++++++++++++++++++++++++++.
  o +++++++++++++++++++++++++++++++++++++++++.
  u ++++++.
  n -------.
  d ----------.
  \r\n [-]+++++++++++++.---.

  Set r1 to negative 1—we'll come back to this
  <->

  Zero out r2 to leave this loop
  [-]
]

Increment r1 as a marker for "is this a GET request to /"
It'll be 0 if it's NOT a GET request
It'll be 1 if it IS a GET request
<+

Head back to r0
<

At this point:
* if r1 == 1 then this is a GET request to /
* else this is NOT a GET request to /

The state of the registers:
* r1 is mentioned above
* everything else is 0
* pointer @ r0

Step 5: grab and print the useragent
====================================

This is the big kahuna

As mentioned above: if r1 == 1 then this is a GET request to /
So let's go through this loop if we should

>[
  Step 5/1: finish the first line of the HTTP request
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  First let's read until we hit the \r character (into r1)
  [,-------------]

  Skip the \n that follows it and then zero out r1
  ,[-]

  Back to r0
  <

  The state of the registers:
  * everything is 0
  * pointer @ r0

  Step 5/2: send "200 OK" and the content type
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Send "200 OK" before we start parsing and printing stuff
  2 ++++++++++++++++++++++++++++++++++++++++++++++++++.
  0 --.
  0 .
    ----------------.
  O +++++++++++++++++++++++++++++++++++++++++++++++.
  K ----.

  "\r\nContent(dash)Type: text/plain\r\n\r\n"
  \r\n [-]+++++++++++++.---.
  C +++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
  o ++++++++++++++++++++++++++++++++++++++++++++.
  n -.
  t ++++++.
  e ---------------.
  n +++++++++.
  t ++++++.
  - ----------------------------------------------------------------------.
  T +++++++++++++++++++++++++++++++++++++++.
  y +++++++++++++++++++++++++++++++++++++.
  p ---------.
  e -----------.
  : -------------------------------------------.
    --------------------------.
  t ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
  e ---------------.
  x +++++++++++++++++++.
  t ----.
  / ---------------------------------------------------------------------.
  p +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
  l ----.
  a -----------.
  i ++++++++.
  n +++++.
  \r\n [-]+++++++++++++.---.
  \r\n +++.---.

  The state of the registers:
  * r0 == 10
  * pointer @ r0

  Step 5/3: find the useragent header
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  HTTP request headers are like HTTP verbs in that you can sum their ASCII codes and get unique values
  You can look at the "List of HTTP header fields" page on Wikipedia to verify this
  "User(dash)Agent: " sums to 1045 so let's set r0 to 1045
  (We use r1 to help here but zero it out when we're done)
  >++++++++++++++++++++++++++++++++[-<++++++++++++++++++++++++++++++++>]<+++++++++++>

  Let's read lines until we see "User(dash)Agent:"
  We will keep looping while r1 == 1
  +[
    At the start of this loop:
    * r0 = 1045
    * r1 = 1

    Let's copy 1045 from r0 into r2 and r3
    * r2 will start at 1045 and we'll decrement it
    * r3 will stay at 1045 so we can reset r0 at the end
    <[->>+>+<<<]

    Read each character up until the space
    all the while subtracting it from r2
    +[
      Read the character into r0
      ,
      Subtract r2 from it and move it to r4
      [->>->>+<<<<]
      Move r4 back to r0
      >>>>[-<<<<+>>>>]
      Subtract 32 from r0 so we can figure out if this is a space
      <<<<--------------------------------
    ]

    Move r3 back into r0
    >>>[-<<<+>>>]

    Now we've read the header key (and the ": ")!

    If our counter (in r2) is 0:
    * we've found our useragent header
    * r1 should be set to 0 so we leave this loop
    If our counter (in r2) is NOT 0:
    * we haven't found our useragent header
    * we should read until the end of the line
    * r1 should be set to 1 so we stay in this loop

    Always decrement r1 (setting it to 0)
    We'll increment it back to 1 if r2 wasn't 0
    <<-

    If we haven't found the header yet we need to
    >[
      Increment r1
      <+>
      Read until the end of the line
      [,----------]
    ]

    Head back to r1
    <
  ]

  Return to r0
  <

  The state of the registers:
  * r0 == 1045
  * pointer @ r0

  Step 5/4: print the useragent
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  This part is pretty easy
  We'll just print every character until we hit \n

  [,.----------]
]

That was horrible
