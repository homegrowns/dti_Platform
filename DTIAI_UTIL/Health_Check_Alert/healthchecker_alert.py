from healthchecker import Checker
import json
import requests
import logging
import re
log = logging.getLogger()
log.setLevel(logging.INFO)

class SystemAlert:
    def __init__(self,systeminfo:json) -> None:
        self.system_info= systeminfo # 데이터 정보 
        self.keylist = {
            'cpuUsage' : 201,
            'cpuTemperature' : 202,
            'gpuUsage' : 203,
            'gpuTemperature' : 204,
            'memoryUsagePercent' : 205,
            'diskUsagePercent' : 206,
            'gpuMemoryUsagePercent' : 207
        }
        systeminfo['memoryUsagePercent']=(systeminfo['memoryUsage']/systeminfo['totalMemory']) * 100
        systeminfo['gpuMemoryUsagePercent']=(systeminfo['gpuMemoryUsage']/systeminfo['gpuMemoryTotal']) * 100
        systeminfo['diskUsagePercent']=(systeminfo['diskUsage']/systeminfo['totalDisk']) * 100
        self.data= []
        self.score,self.warningLevel = self.__get_critical()

    # mongo 연동 예정
    def __get_critical(self) -> tuple:
        score= 85
        warningLevel= 304
        return score,warningLevel
    
    # score 판단 로직 
    def __checker(self,part_name:str='cpuUsage'):
        if self.system_info[part_name] >= self.score: 
            if part_name.__contains__('Temp') is True:
                partUseage= f'{systeminfo[part_name]:.02f}℃' 
            elif part_name.__contains__('Usage') is True:
                partUseage= f'{systeminfo[part_name]:.02f}%' 
            elif part_name.__contains__('Total'):
                partUseage= None
            else:
                partUseage = None
            self.data.append({
                            'alarmCodeId' : self.keylist[part_name],
                            'warningLevelCodeId' : self.warningLevel,
                            "data" :{part_name : f'{partUseage}'},
                            })
        return None
    
    # 각 정보별 판단          
    def __searching(self) -> None:
        for part in self.system_info.keys():
            try:
                self.__checker(part)
            except Exception as e:
                logging.info(e)
        logging.info(json.dumps({'alarmData':self.data})) 
        return json.dumps({'alarmData':self.data}) 
   
    # post 형식으로 해당 url에 데이터 전달 
    def post_data(self,url="http://www.ctilab.cloud/api/alarm/notifySystemStatus") -> None:
        data= self.__searching()
        headers = {'Content-type':'application/json;charset=utf-8','Accept':'text/plain'}
        response = requests.post(url=url,data=data,headers=headers)
        logging.info(response.text)
        return None

if __name__ == '__main__':
    checker = Checker()
    systeminfo = json.loads(checker())
    logging.info(systeminfo)
    alert=SystemAlert(systeminfo)
    alert.post_data()
