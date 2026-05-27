const fs = require('fs');
const readline = require('readline');
const path = require('path');

const logPath = 'C:\\Users\\hchiba\\.gemini\\antigravity\\brain\\ea608d29-ed7d-4fdf-b077-df1ca1616277\\.system_generated\\logs\\transcript.jsonl';

const rl = readline.createInterface({
  input: fs.createReadStream(logPath),
  output: process.stdout,
  terminal: false
});

rl.on('line', (line) => {
  try {
    const obj = JSON.parse(line);
    if (obj.type === 'USER_INPUT') {
      console.log(`[USER]: ${obj.content}`);
    }
  } catch (e) {
    // Ignore invalid JSON
  }
});
