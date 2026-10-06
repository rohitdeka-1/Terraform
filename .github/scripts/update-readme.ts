import * as fs from 'fs';
import * as path from 'path';

const rootDir = path.join(__dirname, '..', '..');
const readmePath = path.join(rootDir, 'README.md');

// Find all directories starting with 'Day' (case-insensitive)
const items = fs.readdirSync(rootDir);
const dayFolders = items
  .filter(item => {
    const itemPath = path.join(rootDir, item);
    return fs.statSync(itemPath).isDirectory() && item.toLowerCase().startsWith('day');
  })
  .sort(); // sort alphabetically

// Generate markdown list
let markdownList = '\n';
for (const folder of dayFolders) {
  // Try to find a readme in the folder
  const folderPath = path.join(rootDir, folder);
  const folderItems = fs.readdirSync(folderPath);
  let readmeFile = folderItems.find(f => f.toLowerCase() === 'readme.md');

  if (readmeFile) {
    markdownList += `- [${folder}](./${folder}/${readmeFile})\n`;
  } else {
    markdownList += `- [${folder}](./${folder})\n`;
  }
}
markdownList += '\n';

// Update README.md
let readmeContent = fs.readFileSync(readmePath, 'utf-8');

const startMarker = '<!-- PROGRESS_START -->';
const endMarker = '<!-- PROGRESS_END -->';

const startIndex = readmeContent.indexOf(startMarker);
const endIndex = readmeContent.indexOf(endMarker);

if (startIndex !== -1 && endIndex !== -1) {
  const before = readmeContent.substring(0, startIndex + startMarker.length);
  const after = readmeContent.substring(endIndex);

  const newReadme = before + markdownList + after;
  fs.writeFileSync(readmePath, newReadme);
  console.log('Successfully updated README.md with progress links.');
} else {
  console.error('Could not find progress markers in README.md');
  process.exit(1);
}
