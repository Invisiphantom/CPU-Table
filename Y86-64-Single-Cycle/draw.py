import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))
files = os.listdir('.')
yo_files = [file for file in files if file.endswith('.yo')]

for yo_file in yo_files:
    with open(yo_file, 'r') as yo_file:
        content = yo_file.readlines()

    txt_file = yo_file.name.replace('.yo', '.txt')
    with open(txt_file, 'w') as txt_file:
        for line in content:
            hex_instruction = line.strip().split('|')[0].strip().split(':')[-1].strip()
            
            # 将 hex_instruction 切割为一字节一行
            hex_instruction = [hex_instruction[i:i+2] for i in range(0, len(hex_instruction), 2)]
            hex_instruction = '\n'.join(hex_instruction)
            
            if hex_instruction != '':
                txt_file.write(hex_instruction + '\n')
        
        # 最后再写入 10行的 00
        txt_file.write('\n'.join(['00' for i in range(10)]))
