because some punctuation is valid brainfuck there is very little punctuation in these comments

this is a server that returns your user-agent back to you if you sent a GET request to / and returns a 404 otherwise

************

first let us send "HTTP/1 dot 1 " in a nonclever way
H +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
T ++++++++++++.
T .
P ----.
/ [-]+++++++++++++++++++++++++++++++++++++++++++++++.
1 ++.
dot ---.
1 +++.
space -----------------.

************

next we must determine whether this is a GET request

turns out that if you sum the ASCII values of each character in GET or PUT (etc) you get different numbers (GET = 224; POST = 326; etc)

GET is the only thing that sums to 224 and with a space that's 256

this is fabulous for us; we start by creating 256 then subtract the ASCII sum to from number

if this number is 0 then we skip to the end and send a 404

let's make register 0 become 256
>+++++++++++++++++[-<+++++++++++++>]<+++


************

okay so here's the plan

we're gonna read every character and increment register 0 until we see a spac

if register 0 is not 0 then we know it's not a GET request so we will skip all the way to 404 land; otherwise we stay

head to r1 and make sure we run the following loop at least once

>+[
  this loop starts at r1 which should be initialized to 32
  we start by adding a bajillion numbers to it to make sure it's definitely positive
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  [-]++++++++++++++++++++++++++++++++

  grab a character into register 2
  >,

  subtract its value from the total ASCII sum (r0)
  and subtract its value from 32 (r1)
  [-<-<->>]

  head back to register 1
  <
]

increment r2; we'll come back to this later
>+

did we get a GET request? if so we will skip all of this bullhonkey
<<[
  head to r1 which we know is 0 at this point
  >

  4 ++++++++++++++++++++++++++++++++++++++++++++++++++++.
  0 ----.
  4 ++++.
  space --------------------.
  N ++++++++++++++++++++++++++++++++++++++++++++++.
  o +++++++++++++++++++++++++++++++++.
  t +++++.
  space ------------------------------------------------------------------------------------.
  F ++++++++++++++++++++++++++++++++++++++.
  o +++++++++++++++++++++++++++++++++++++++++.
  u ++++++.
  n -------.
  d ----------.

  head to r2 which we will make sure is zero doesn't run
  remember this from before?
  >-

  zero out r1
  <[-]

  zero out r0 (which should be negative at this point)
  <[+]
]

head to r2

>>[
  2 +++++++++++++++++++++++++++++++++++++++++++++++++.
  0 --.
  0 .
  space ----------------.
  O +++++++++++++++++++++++++++++++++++++++++++++++.
  K ----.

  send \r\n
  [-]+++++++++++++.---.

  head back to r0 which is 0 so the loop is done
  <<
]

send \r\n
+++++++++++++. ---.
