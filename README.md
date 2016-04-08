a Brainfuck web app
===================

This is a web app that returns your useragent to you in plain text. The tricky bit: it's written in Brainfuck.

Get this app set up
-------------------

```
# clone this and cd inside
npm install
npm start
```

How does this work?
-------------------

I wrote a small Node server (`server.js`) that's kind of like CGI for Brainfuck. It takes the bytes from a TCP stream and sends them to Brainfuck (`server.bf`), responding with the Brainfuck program's result.
