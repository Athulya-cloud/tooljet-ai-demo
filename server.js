const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ status: 'ok', message: 'ToolJet AI Server' }));
});

server.listen(8000, () => {
  console.log('ToolJet AI Server running on port 8000');
});
