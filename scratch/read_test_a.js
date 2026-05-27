const fs = require('fs');
const readline = require('readline');

const logPath = 'C:\\Users\\hchiba\\.gemini\\antigravity\\brain\\0525a418-213f-4453-9be2-87f8e96b27f5\\.system_generated\\logs\\transcript.jsonl';

if (!fs.existsSync(logPath)) {
  console.log('Log file does not exist at:', logPath);
  process.exit(1);
}

const rl = readline.createInterface({
  input: fs.createReadStream(logPath),
  output: process.stdout,
  terminal: false
});

console.log('--- Scanning test-a transcript ---');
rl.on('line', (line) => {
  try {
    const obj = JSON.parse(line);
    if (obj.type === 'USER_INPUT') {
      console.log(`[USER]: ${obj.content}`);
    } else if (obj.tool_calls) {
      obj.tool_calls.forEach(tc => {
        if (tc.name === 'write_to_file' || tc.name === 'replace_file_content' || tc.name === 'multi_replace_file_content') {
          console.log(`[EDIT] ${tc.name} on ${tc.args.TargetFile || tc.args.Target}`);
        }
      });
    }
  } catch (e) {
  }
});
