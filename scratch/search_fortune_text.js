const fs = require('fs');
const readline = require('readline');

const logPath = 'C:\\Users\\hchiba\\.gemini\\antigravity\\brain\\c765b32c-aeee-4848-ae7c-595b099c8a92\\.system_generated\\logs\\transcript.jsonl';

const rl = readline.createInterface({
  input: fs.createReadStream(logPath),
  output: process.stdout,
  terminal: false
});

console.log('--- Printing past chat messages ---');
rl.on('line', (line) => {
  try {
    const obj = JSON.parse(line);
    if (obj.source === 'USER_EXPLICIT' || obj.type === 'USER_INPUT') {
      console.log(`[USER]: ${obj.content}`);
    } else if (obj.type === 'PLANNER_RESPONSE') {
      console.log(`[MODEL]: ${obj.content.substring(0, 300)}...`);
    }
  } catch (e) {
  }
});
