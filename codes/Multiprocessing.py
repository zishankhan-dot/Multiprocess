import threading
import time

Tasks= 10000

def tasks():
    time.sleep(0.1)

threads=[]

for i in range(Tasks):
    t=threading.Thread(target=tasks)
    t.start()
    threads.append(t)
for t in threads: 
    t.join()


