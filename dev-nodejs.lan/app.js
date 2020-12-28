const server = require('polka')()

server.get('/', (req, res)=>{ console.log('New request.'), res.end('Hello world.') })

console.log('Server running.')
server.listen(80)