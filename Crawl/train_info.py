import json
import requests
import re
import os
from bs4 import BeautifulSoup

# 获取每个车次具体行程
# arrive_time,running_time,start_time,station_name,station_no,station_train_code
# 每个的第一个还有：train_class_name
def getTrainStation(train_no,date):
    headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.42',
        'Cookie': 'tk=MLbY49l6WQ0fvF6nibmF7A0l_4zBPTFFJWzRTy0JbvzSpuVhmkY1Y0; JSESSIONID=A3102E378BA5E4E99F6DFF9F17815507; RAIL_EXPIRATION=1680820648934; RAIL_DEVICEID=FcSQnRPvLR1Z8Idbb7IYSp4O6ZDeHaBROaMJA3T0sv1T1GzzRPk9HhTiw42UZ4JjR1WPH6odW3A8Ur938ytUp40mwANKSgdLUg72AQYqPVAU_2uwPQnai-Cc4KwwXliVlb5ClxOM_vG4m6GQrEX-Ktb3FGJ8acA3; BIGipServerotn=1088946442.50210.0000; BIGipServerpassport=820510986.50215.0000; guidesStatus=off; highContrastMode=defaltMode; cursorStatus=off; fo=undefined; route=6f50b51faa11b987e576cdb301e545c4; _jc_save_fromStation=%u5317%u4EAC%2CBJP; _jc_save_toDate=2023-05-16; _jc_save_wfdc_flag=dc; current_captcha_type=C; _jc_save_toStation=%u5929%u6D25%2CBJP; _jc_save_fromDate=2023-05-17',
        'Host': 'kyfw.12306.cn',
        'Referer': 'https://kyfw.12306.cn/otn/queryTrainInfo/init',
        'X-Requested-With': 'XMLHttpRequest'
    }
    station_url='https://kyfw.12306.cn/otn/queryTrainInfo/query?leftTicketDTO.train_no=%s&leftTicketDTO.train_date=%s&rand_code='%(train_no,date)

    try:
        res = requests.get(url=station_url, headers=headers)
        text = json.loads(res.text)
        data=text['data']
        data=data['data']
        return data

    except Exception as e:
        print("运行失败！")

def getData(date,type):

    day=date.replace('-','')
    dir = "./%s_%s_list.json" % (type, day)
    with open(dir, 'r', encoding='utf-8') as fp:
        train = json.load(fp)

    station = []
    flag=0
    for x in train:
        train_no = x.get('train_no')
        station = getTrainStation(train_no, date)
        while not station: # station 为空 再来一次
            station = getTrainStation(train_no, date)

        path = "./%s/%s_type"%(day,type)
        if not os.path.exists(path): # 若没有文件夹，则递归创建文件夹
            os.makedirs(path)
        dir = "./%s/%s_type/%s.json" % (day, type, x.get('station_train_code'))
        with open(dir, 'w+', encoding='utf-8') as f:
            json.dump(station, f, ensure_ascii=False)

        print("已完成列车号为%s的存储" % (x.get('station_train_code')))
        print("存储数据量为%d" % len(station))

# 打开train_list 后获取 train_no 并逐个扫描
for i in range(8):
    date='2023-05-2'+str(i)
    print("当前日期为%s"%date)
    getData(date,'C')
    getData(date, 'D')
    getData(date, 'G')





