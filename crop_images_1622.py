import os
from PIL import Image

def crop_to_16_9(image_path, output_path):
    try:
        img = Image.open(image_path)
        width, height = img.size
        
        target_ratio = 16.0 / 9.0
        current_ratio = width / height
        
        if current_ratio > target_ratio:
            new_width = int(height * target_ratio)
            left = (width - new_width) // 2
            right = width - left
            top = 0
            bottom = height
        else:
            new_height = int(width / target_ratio)
            top = (height - new_height) // 2
            bottom = height - top
            left = 0
            right = width
            
        cropped_img = img.crop((left, top, right, bottom))
        
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        cropped_img.save(output_path)
        print(f"Successfully cropped and saved {output_path}")
    except Exception as e:
        print(f"Error processing {image_path}: {e}")

images = {
    r"C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\01_eyecatch_friction_1778390212041.png": "01_eyecatch.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\02_h2_inefficiency_1778390227363.png": "02_h2_inefficiency.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\03_h2_acceptance_1778390243208.png": "03_h2_acceptance.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\04_h2_waiting_1778390259577.png": "04_h2_waiting.png"
}

output_dir = "99_Shared_Outputs/note_assets/1622"
os.makedirs(output_dir, exist_ok=True)

for in_path, out_name in images.items():
    out_path = os.path.join(output_dir, out_name)
    crop_to_16_9(in_path, out_path)
