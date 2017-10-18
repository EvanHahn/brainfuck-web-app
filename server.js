const net = require('net')
const brainfuck = require('brainfuck2000')
const fs = require('fs')
const path = require('path')

const PORT = process.env.PORT || 3000
const BF_PATH = path.resolve(__dirname, 'server.bf')

const server = net.createServer((socket) => {
  socket.on('data', (req) => {
    req = req.toString()

    fs.readFile(BF_PATH, { encoding: 'utf8' }, (err, bfSource) => {
      if (err) { throw err }

      const program = brainfuck(bfSource)
      program.run(req)
      const res = program.resultString()

      socket.end(res)
    })
  })
})

server.on('error', (err) => {
  throw err
})

server.listen(PORT, () => {
  console.log('opened server on %s', server.address().port)
})
