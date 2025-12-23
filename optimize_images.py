import os
import glob
from PIL import Image

def optimize_images(raw_dir="raw_images", out_dir="public/missions", max_width=800):
    if not os.path.exists(raw_dir):
        print(f"Directory '{raw_dir}' not found. Please create it and add your source images there.")
        os.makedirs(raw_dir)
        return

    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

    # Supported formats
    extensions = ['*.png', '*.jpg', '*.jpeg', '*.webp']
    files = []
    for ext in extensions:
        files.extend(glob.glob(os.path.join(raw_dir, ext)))
    
    print(f"Found {len(files)} images in '{raw_dir}'...")

    for filepath in files:
        filename = os.path.basename(filepath)
        name, _ = os.path.splitext(filename)
        out_path = os.path.join(out_dir, f"{name}.webp")
        
        try:
            with Image.open(filepath) as img:
                # Resize if needed
                if img.width > max_width:
                    ratio = max_width / img.width
                    new_height = int(img.height * ratio)
                    img = img.resize((max_width, new_height), Image.Resampling.LANCZOS)
                
                # Save as WebP
                img.save(out_path, "WEBP", quality=80)
                print(f"Optimized: {filename} -> {name}.webp")
                
        except Exception as e:
            print(f"Error processing {filename}: {e}")

    print("Optimization complete.")

if __name__ == "__main__":
    optimize_images()
