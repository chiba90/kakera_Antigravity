const fs = require('fs');
const path = require('path');

const dir = 'c:\\Users\\hchiba\\Dropbox\\$_個人的なやーつ\\Kakera\\kakera_Antigravity\\.agent\\skills';
const list = fs.readdirSync(dir);
list.forEach(file => {
  const fullPath = path.join(dir, file);
  const lstat = fs.lstatSync(fullPath);
  if (lstat.isSymbolicLink()) {
    console.log(`${file} is SymLink -> ${fs.readlinkSync(fullPath)}`);
  } else {
    console.log(`${file} is NOT SymLink`);
  }
});
