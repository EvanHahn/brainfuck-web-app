a Brainfuck web app
===================

This is a web app that returns your useragent to you in plain text. The tricky bit: it's written in Brainfuck.

![screenshot](https://cloud.githubusercontent.com/assets/777712/14399473/ee4bda32-fda1-11e5-85b2-a906ec8f2982.png)

Get this app set up
-------------------

```
# clone this and cd inside
npm install
npm start
```

Visit it at `http://localhost:3000`. Try hitting other URLs to notice your 404 errors!

How does this work?
-------------------

I wrote a small Node server (`server.js`) that's kind of like CGI for Brainfuck. It takes the bytes from a TCP stream and sends them to Brainfuck (`server.bf`), responding with the Brainfuck program's result.
