const fs = require('fs');
const path = require('path');
const readline = require('readline');

async function extractFiles() {
  const logFile = 'C:\\Users\\hchiba\\.gemini\\antigravity\\brain\\4357e05b-31a1-4b79-8e9d-c5af36a47ae4\\.system_generated\\logs\\transcript.jsonl';
  const rl = readline.createInterface({
    input: fs.createReadStream(logFile),
    crlfDelay: Infinity
  });

  for await (const line of rl) {
    try {
      const step = JSON.parse(line);
      
      // 1. Check VIEW_FILE tool response content
      if (step.type === 'VIEW_FILE' && step.content) {
        const filePathMatch = step.content.match(/File Path: `file:\/\/\/(.*?)`/);
        if (filePathMatch) {
          let filePath = filePathMatch[1].replace(/%E5%80%8B%E4%BA%BA%E7%9A%84%E3%81%AA%E3%82%84%E3%83%BC%E3%81%A4/g, '$_個人的なやーつ');
          // Standardize separators
          filePath = path.normalize(filePath);
          if (filePath.includes('.agent')) {
            // Reconstruct original content by stripping line numbers
            const lines = step.content.split('\n');
            const fileLines = [];
            let inCode = false;
            for (const l of lines) {
              if (l.includes('The following code has been modified to include a line number before every line')) {
                inCode = true;
                continue;
              }
              if (l.includes('The above content shows the entire, complete file contents')) {
                inCode = false;
                continue;
              }
              if (inCode) {
                const match = l.match(/^\d+:\s?(.*)$/);
                if (match) {
                  fileLines.push(match[1]);
                } else if (l.trim() === '') {
                  fileLines.push('');
                }
              }
            }
            if (fileLines.length > 0) {
              const fileContent = fileLines.join('\n');
              const localPath = path.join('c:\\Users\\hchiba\\Dropbox\\$_個人的なやーつ\\Kakera\\kakera_Antigravity', filePath.substring(filePath.indexOf('.agent')));
              console.log('Restoring from VIEW_FILE:', localPath);
              fs.mkdirSync(path.dirname(localPath), { recursive: true });
              fs.writeFileSync(localPath, fileContent, 'utf8');
            }
          }
        }
      }

      // 2. Check WRITE_TO_FILE or REPLACE_FILE_CONTENT or run_command args
      if (step.tool_calls) {
        for (const tc of step.tool_calls) {
          if (tc.name === 'write_to_file' && tc.args) {
            let args = tc.args;
            if (typeof args === 'string') {
              try { args = JSON.parse(args); } catch (e) {}
            }
            if (args.TargetFile && args.TargetFile.includes('.agent')) {
              let target = args.TargetFile.replace(/\\+/g, '/').replace(/"/g, '');
              let content = args.CodeContent;
              if (content) {
                content = content.replace(/^"|"$/g, '').replace(/\\n/g, '\n').replace(/\\"/g, '"');
                const localPath = path.join('c:\\Users\\hchiba\\Dropbox\\$_個人的なやーつ\\Kakera\\kakera_Antigravity', target.substring(target.indexOf('.agent')));
                console.log('Restoring from write_to_file:', localPath);
                fs.mkdirSync(path.dirname(localPath), { recursive: true });
                fs.writeFileSync(localPath, content, 'utf8');
              }
            }
          }
        }
      }
    } catch (e) {
      // Ignore parse errors
    }
  }
}

extractFiles().then(() => console.log('Done!'));
