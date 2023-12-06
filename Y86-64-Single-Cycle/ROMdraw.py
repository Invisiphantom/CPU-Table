#!/usr/bin/env python3
import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))
files = os.listdir(".")
yo_files = [file for file in files if file.endswith(".yo")]

for yo_file in yo_files:
    with open(yo_file, "r") as yo_file:
        yo_content = yo_file.readlines()

    txt_file = yo_file.name.replace(".yo", ".txt")
    with open(txt_file, "w") as txt_file:
        # 首先写入1024行的 00
        txt_content = ["00" for i in range(1024)]

        for line in yo_content:
            if len(line.strip().split("|")[0].strip().split(":")) != 2:
                continue
            hex_address = line.strip().split("|")[0].strip().split(":")[0].strip()
            hex_instruction = line.strip().split("|")[0].strip().split(":")[1].strip()
            dec_address = int(hex_address, 16)
            for i in range(0, int(len(hex_instruction) / 2)):
                txt_content[dec_address + i] = hex_instruction[i * 2 : i * 2 + 2]

        txt_file.write("\n".join(txt_content))
