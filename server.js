const net = require('net')
const brainfuck = require('brainfuck2000')
const fs = require('fs')
const path = require('path')
const chalk = require('chalk')

const PORT = 3000
const BF_PATH = path.resolve(__dirname, 'server.bf')

const server = net.createServer((socket) => {
  socket.on('data', (req) => {
    req = req.toString()

    fs.readFile(BF_PATH, { encoding: 'utf8' }, (err, bfSource) => {
      if (err) { throw err }

      const program = brainfuck(bfSource)
      program.run(req)
      const res = program.resultString()

      console.log(chalk.blue(req.trim()))
      console.log(chalk.red(program.tape))
      console.log(chalk.yellow(res))

      socket.end(res)
    })
  })
})

server.on('error', (err) => {
  throw err;
});

server.listen(PORT, () => {
  console.log('opened server on %s', server.address().port);
})
