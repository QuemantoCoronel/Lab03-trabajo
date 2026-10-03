const http = require('http');

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Backend Node en ejecucion\n');
});

server.listen(3000, '0.0.0.0', () => {
});