import os
import json
data=[]
path="./2021/C_type"
if not os.path.exists(path):
    os.makedirs(path)
dir = "./2021/C_type/s.json"
with open(dir, 'w+', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False)