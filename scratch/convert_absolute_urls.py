import os
import re

assets_dir = r"c:\Users\hchiba\Dropbox\$_個人的なやーつ\Kakera\kakera_Antigravity\99_Shared_Outputs\final_assets"

# Targets for conversion
targets = {
    "kasuga_shinroku": "index.html",
    "karamoushi_orihime": "karamoushi_orihime.html",
    "shino_ando_takumi": "curation_shino_ando_takumi.html",
    "uchiyama_paper": "uchiyama_paper.html",
}

img_pattern = re.compile(r'src=["\'](?![a-zA-Z]+://)([^"\']+)["\']')

for project, filename in targets.items():
    file_path = os.path.join(assets_dir, project, filename)
    if not os.path.exists(file_path):
        print(f"File not found: {file_path}")
        continue
        
    print(f"Processing {project}/{filename}...")
    
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    # Replace with absolute URLs
    replaced_content, count = img_pattern.subn(f'src="https://kakera.inc/wp-content/uploads/final_assets/{project}/\\1"', content)
    
    if count > 0:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(replaced_content)
        print(f"  Successfully replaced {count} image URLs in {filename}")
    else:
        print(f"  No relative image URLs found in {filename}")
