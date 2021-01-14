const server = require('polka')()

server.get('/', (req, res)=>{ console.log('New request.'), res.end('Hello world.') })

console.log('Server running.')
const PORT = process.env.PORT || 5000
server.listen(PORT)
