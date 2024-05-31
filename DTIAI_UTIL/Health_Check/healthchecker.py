import psutil
import os
import json
import gpu_util_custom
import subprocess
from typing import Union
from fastapi import FastAPI

class Checker:
    def __init__(self) -> None:
        pass
    
    def __get_gpu_temperature(self):
        result = subprocess.run(['nvidia-smi', '--query-gpu=temperature.gpu', '--format=csv,noheader,nounits'], stdout=subprocess.PIPE)
        temperature = int(result.stdout.decode().strip())
        return temperature

    def __call__(self):
       # CPU 사용량 체크
        cpu_percent = psutil.cpu_percent()
        cpu_temperature= int(psutil.sensors_temperatures()['coretemp'][0].current)
        # 메모리 사용량 체크
        memory_total= round(psutil.virtual_memory().total/1024**3,2)
        memory_use =  round(psutil.virtual_memory().used/1024**3,2)
        # 디스크 사용량 체크
        disk_total= round(psutil.disk_usage('/').total/1024**4,2)
        disk_free= round(psutil.disk_usage('/').free/1024**4,2)
        disk_usage = round(disk_total-disk_free,2)
        #disk_usage = disk_total-disk_free
        # gpu 사용량 체크
        gpu, gpu_load, gpu_memory_total,gpu_memory_use = gpu_util_custom.showUtilization()
        gpu_memory_total = round(gpu_memory_total/1000,2)
        gpu_memory_use = round(gpu_memory_use/1000,2) 
        gputemp =  self.__get_gpu_temperature()
        
        system_info ={
        'cpuUsage' : cpu_percent,         
        'cpuTemperature' : cpu_temperature,         
        'memoryUsage' : memory_use,
        'totalMemory' : memory_total,
        'totalDisk' : disk_total,
        'diskUsage' : disk_usage,
        'gpuMemoryTotal' : gpu_memory_total,
        'gpuMemoryUsage' : gpu_memory_use,
        'gpuUsage' : gpu_load,
        'gpuTemperature' : gputemp,
        }
        return json.dumps(system_info)


app = FastAPI()

@app.get("/health")
def read_data():
    checker = Checker()
    system_info = checker()
    return system_info

         
if __name__ == '__main__':
    checker = Checker() 
    system_info=checker()
    print(system_info)
