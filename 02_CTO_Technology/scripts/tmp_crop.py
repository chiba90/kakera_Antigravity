from PIL import Image
import os

image_paths = [
    r"C:\Users\hchiba\.gemini\antigravity\brain\985af412-aed1-4f98-bccd-372b8e3269d4\img1_hotel_architect_1774580374337.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\985af412-aed1-4f98-bccd-372b8e3269d4\img2_castle_stone_1774580390691.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\985af412-aed1-4f98-bccd-372b8e3269d4\img3_material_macro_1774580405754.png",
    r"C:\Users\hchiba\.gemini\antigravity\brain\985af412-aed1-4f98-bccd-372b8e3269d4\img4_ceramic_bowl_1774580420913.png"
]

download_dir = os.path.expanduser('~/Downloads')
os.makedirs(download_dir, exist_ok=True)

target_width = 640
target_height = 360

for path in image_paths:
    if os.path.exists(path):
        try:
            img = Image.open(path)
            img = img.resize((target_width, target_width), Image.Resampling.LANCZOS)
            
            left = 0
            top = (target_width - target_height) / 2
            right = target_width
            bottom = (target_width + target_height) / 2
            
            cropped_img = img.crop((left, top, right, bottom))
            
            filename = os.path.basename(path).replace(".png", "_16x9.png")
            save_path = os.path.join(download_dir, filename)
            cropped_img.save(save_path)
            
            img.close()
            os.remove(path)
            print(f"Processed and saved: {save_path}, original deleted.")
        except Exception as e:
            print(f"Error processing {path}: {e}")
    else:
        print(f"File not found: {path}")
