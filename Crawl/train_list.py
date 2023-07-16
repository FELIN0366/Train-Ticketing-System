# 爬取各城市与车次
# 12306将全国列车分成了7类，C-城际高速，D-动车，G-高铁，K-普快，T-特快，Z-直达，O-其他列车。
# 我们只存：C-城际高速，D-动车，G-高铁
# 暂时只存”20230518“这一天的数据

# 存表
# 1 所有列车信息
# 'date','from_station','station_train_code','to_station','total_num','train_no'
# 2 每辆列车以station_train_code存一张表
# arrive_time,running_time,start_time,station_name,station_no,station_train_code
# 每个的第一个还有：train_class_name

# 存20230520-20230525 六天得车辆信息
# 座位没存 因为这个应该是实时获取的

import json
import time

import requests
import os
import random
from bs4 import BeautifulSoup

# 1 获取列车信息并进行处理
# 'date','from_station','station_train_code','to_station','total_num','train_no'
def getTrainName(keyword,date):
    # C1-C9 若数据到达199个，就需要获取第199个数据由其前1位往后搜索便利，直到其数据不足199个，则不用深入
    headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.42',
        'Host': 'search.12306.cn'
    }
    train_url='https://search.12306.cn/search/v1/train/search?keyword=%s&date=%s'%(keyword,date)

    try:
        res=requests.get(url=train_url,headers=headers)
        text=json.loads(res.text)
        data=text['data']

        return data

    except Exception as e:
        print("运行失败！")


# keyword:搜索什么 num:搜索位数
def processTrainName(keyword, num):
    global trains
    # 对keyword进行一些处理 C1 C12
    code = int(keyword[num])
    while True:
        sleeptime=random.randint(0,5)
        time.sleep(sleeptime)

        train = getTrainName(keyword, date)
        trains.extend(train)
        print("目前获取到keyword为%s的数据" % keyword)
        print("该数据量为%d"%len(train))

        if len(train) >= 199:
            # 说明此处未找完 C1没找完 C1230 12往后找 就会有重复 找机会删除重复
            key = train[-1].get('station_train_code')  # 取最后一个列车的号
            key = key[:num + 2]  # 搜索位数
            processTrainName(key, num + 1)  # 继续搜索

        code += 1
        if code == 10:
            break
        else:
            k=list(keyword)
            k[num]=str(code)
            keyword=''.join(k)

def getData(date,begin):
    global trains
    trains=[]
    processTrainName(begin, 1)
    dir = "./%s_%s_list.json"%(begin[0],date) # C_20230520_list
    with open(dir, 'w+', encoding='utf-8') as f:
        json.dump(trains, f, ensure_ascii=False)

# 我们只存：C-城际高速，D-动车，G-高铁

trains=[]
for i in range(3,8):
    date='2023052'+str(i)
    print("当前日期为%s"%date)
    if i !=0:
        getData(date,'C1')
    getData(date,'D0')
    getData(date,'G0')











