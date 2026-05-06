from PIL import Image
import numpy as np

width = 256
height = 256

pixels = []

with open("output.hex") as f:
    for line in f:
        pixels.append(int(line.strip(),16))

img_array = np.array(pixels, dtype=np.uint8).reshape((height,width))
img = Image.fromarray(img_array)

img.save("output.png")
