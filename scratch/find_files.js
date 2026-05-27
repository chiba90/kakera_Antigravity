const fs = require('fs');
const path = require('path');

const dir = 'C:\\Users\\hchiba\\.gemini';

function findFiles(dir, filter) {
  let results = [];
  if (!fs.existsSync(dir)) return results;
  const list = fs.readdirSync(dir);
  list.forEach((file) => {
    const fullPath = path.join(dir, file);
    const stat = fs.statSync(fullPath);
    if (stat && stat.isDirectory()) {
      if (file !== 'node_modules' && file !== 'brain' && file !== 'conversations') {
        results = results.concat(findFiles(fullPath, filter));
      }
    } else {
      if (filter(file)) {
        results.push(fullPath);
      }
    }
  });
  return results;
}

const mdFiles = findFiles(dir, (f) => f.endsWith('.md') || f.endsWith('.ps1') || f.endsWith('.mjs') || f.endsWith('.js'));
console.log('Found files:', mdFiles.length);
mdFiles.forEach(f => console.log(f));
