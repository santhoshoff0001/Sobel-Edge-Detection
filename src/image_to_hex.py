from PIL import Image
import numpy as np
import sys

if len(sys.argv) != 2:
    print("Usage: python3 image_to_hex.py <image_name>")
    exit()

IMAGE_NAME = sys.argv[1]

img = Image.open(IMAGE_NAME).convert("L")
img = img.resize((256, 256))

pixels = np.array(img)

with open("input.hex", "w") as f:
    for row in pixels:
        for pixel in row:
            f.write(f"{pixel:02x}\n")

print(f"input.hex generated from {IMAGE_NAME}")
