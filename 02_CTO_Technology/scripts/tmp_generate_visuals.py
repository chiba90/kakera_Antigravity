import os
import urllib.request
from pathlib import Path

# Since standard python image and plot libraries may not be available, 
# I will try to import them. If missing, I will just use subprocess to pip install them briefly.
def install_requirements():
    import subprocess
    import sys
    try:
        import matplotlib
        from PIL import Image
    except ImportError:
        print("Installing matplotlib and Pillow...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "matplotlib", "Pillow"])

install_requirements()

import matplotlib.pyplot as plt
import matplotlib.patches as patches
from PIL import Image

brain_dir = Path(r"C:\Users\hchiba\.gemini\antigravity\brain\93a40728-4b1c-436c-b75e-f7de9237d686")
downloads_dir = Path(r"C:\Users\hchiba\Downloads")
downloads_dir.mkdir(parents=True, exist_ok=True)

def crop_16_9(img_path, output_path):
    with Image.open(img_path) as img:
        img = img.convert("RGB")
        w, h = img.size
        # target width = w, target height = w * 9/16
        new_h = int(w * 9 / 16)
        if h > new_h:
            top = (h - new_h) // 2
            bottom = top + new_h
            cropped = img.crop((0, top, w, bottom))
        else:
            cropped = img
        resized = cropped.resize((640, 360), Image.Resampling.LANCZOS)
        resized.save(output_path, "PNG")

def generate_chart():
    plt.style.use('dark_background')
    fig, ax = plt.subplots(figsize=(10, 5.625), dpi=120)  # 1200x675
    ax.set_facecolor('#111111')
    fig.patch.set_facecolor('#111111')
    
    x = ['2010s', '2020s', '2026~']
    y = [100, 150, 280]
    
    ax.plot(x, y, color='#d4af37', marker='o', linewidth=3, markersize=8)
    
    ax.annotate('Functional\nCrafts', xy=(0, 110), color='#aaaaaa', ha='center', va='bottom')
    ax.annotate('Premium\nEvaluation', xy=(1, 160), color='#aaaaaa', ha='center', va='bottom')
    ax.annotate('Investment Asset\nFine Art', xy=(2, 290), color='#d4af37', ha='center', va='bottom')

    ax.set_ylim(0, 350)
    ax.set_yticks([])
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['bottom'].set_color('#555555')
    ax.tick_params(axis='x', colors='#cccccc', labelsize=12)
    
    plt.title('Global Market Evaluation: Traditional Craft as Fine Art', color='#ffffff', loc='left', pad=20, fontsize=14)
    tmp_path = brain_dir / "tmp_chart1.png"
    plt.tight_layout()
    plt.savefig(tmp_path, facecolor=fig.get_facecolor(), bbox_inches='tight', dpi=120)
    plt.close()
    
    out_path = downloads_dir / "chart_craft_art_market.png"
    crop_16_9(tmp_path, out_path)
    os.remove(tmp_path)

def generate_diagram():
    fig, ax = plt.subplots(figsize=(10, 5.625), dpi=120)
    fig.patch.set_facecolor('#fdfcfb')
    ax.set_facecolor('#fdfcfb')
    
    rect1 = patches.Rectangle((0.15, 0.35), 0.2, 0.3, linewidth=1, edgecolor='#555', facecolor='#eee')
    rect2 = patches.Rectangle((0.65, 0.3), 0.2, 0.4, linewidth=1, edgecolor='#b39d82', facecolor='none', hatch='///')
    ax.add_patch(rect1)
    ax.add_patch(rect2)
    
    ax.annotate("", xy=(0.6, 0.5), xytext=(0.4, 0.5), arrowprops=dict(arrowstyle="->", color="#888", lw=2))
    
    ax.text(0.25, 0.7, 'Painting\n(2D / Pigment)', ha='center', fontsize=12, color='#333')
    ax.text(0.75, 0.75, 'Nishijin-ori\n(3D / Silk & Shadow)', ha='center', fontsize=12, color='#b39d82', fontweight='bold')
    
    ax.text(0.25, 0.25, 'Visual as\nLine & Color', ha='center', fontsize=10, color='#666')
    ax.text(0.5, 0.55, 'Sublimation\n(Light Reflection)', ha='center', fontsize=10, color='#888')
    ax.text(0.75, 0.2, 'Visual as Structure\nDynamic Multi-facet', ha='center', fontsize=10, color='#b39d82')
    
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')
    
    tmp_path = brain_dir / "tmp_diagram1.png"
    plt.savefig(tmp_path, facecolor=fig.get_facecolor(), bbox_inches='tight', dpi=120)
    plt.close()
    
    out_path = downloads_dir / "diagram_nishijin_sublimation.png"
    crop_16_9(tmp_path, out_path)
    os.remove(tmp_path)

def process_mood_images():
    mood1_org = brain_dir / "mucha_nishijin_mood1_1774589399637.png"
    mood2_org = brain_dir / "mucha_nishijin_mood2_1774589415962.png"
    out1 = downloads_dir / "mood_nishijin_mucha_1.png"
    out2 = downloads_dir / "mood_nishijin_mucha_2.png"
    
    if mood1_org.exists():
        crop_16_9(mood1_org, out1)
        os.remove(mood1_org)
    if mood2_org.exists():
        crop_16_9(mood2_org, out2)
        os.remove(mood2_org)

if __name__ == "__main__":
    generate_chart()
    generate_diagram()
    process_mood_images()
    print("Visual generation and cropping successful.")
