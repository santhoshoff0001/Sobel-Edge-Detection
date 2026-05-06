# Real-Time Sobel Edge Detection in Verilog

## Overview
This repository contains an RTL implementation of the Sobel Edge Detection algorithm written in Verilog. It is verified using a custom Ubuntu terminal simulation environment before being ported to hardware.

## Technical Stack
* **Language:** Verilog HDL
* **Simulation:** Icarus Verilog (`iverilog`)
* **Tools:** Xilinx Vivado, Gowin EDA
* **Hardware Target:** Tang Nano 9K FPGA 
* **Scripting:** Python 3 (Ubuntu environment)

## Project Files
* `sobel_core.v`: 3x3 convolution matrix logic for gradient calculation.
* `line_buffer.v`: Memory buffering for the sliding window.
* `uart_tx.v`: UART transmission module.
* `tb_sobel.v`: Testbench for image verification.

## How to Run on Ubuntu
1. Open your Ubuntu terminal and navigate to the source directory:
   ```bash
   cd src
   ```

2. Convert the input image to hexadecimal format:
   ```bash
   python3 image_to_hex.py 3.png
   ```

3. Compile the Verilog files:
   ```bash
   iverilog -o sobel_sim top.v line_buffer.v sobel_core.v tb_sobel.v
   ```

4. Run the simulation:
   ```bash
   vvp sobel_sim
   ```

5. Convert the hex output back to a viewable image:
   ```bash
   python3 hex_to_image.py
   mv output.png edge_detected_output.png
   ```
