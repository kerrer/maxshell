#!/usr/bin/python

import Queue
import threading
import time
import os,sys, getopt,subprocess
import argparse
import re


exitFlag = 0
queueLock = threading.Lock()
workQueue = Queue.Queue(100)
threads = []

rrs = r"""
    ^         # begin
    ([^\s]+)   # match everything but a comma
    \s+
    (\(.+\))     # match everything, until next match occurs
    $         # end
"""
rr = re.compile(rrs, re.VERBOSE)

class myThread (threading.Thread):
    def __init__(self, threadID, name, q):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.q = q
    def run(self):
        print "Starting " + self.name
        process_data(self.name, self.q)
        print "Exiting " + self.name

def process_data(threadName, q):
    while not exitFlag:
        queueLock.acquire()
        if not workQueue.empty():
            pName = q.get()
            queueLock.release()
            print "%s processing plugin: %s" % (threadName, pName)
            subprocess.call("vagrant plugin install {}".format(pName),shell=True)
        else:
            queueLock.release()
        time.sleep(1)

def main(f,numOfThreads):
    threadID = 1
    # Create new threads
    for i in range(numOfThreads):
        tName = "Thread-{}".format(i+1)
        thread = myThread(threadID, tName, workQueue)
        thread.start()
        threads.append(thread)
        threadID += 1
    
    queueLock.acquire()
    for line in f:
        temp= rr.findall(line)
        workQueue.put(temp[0][0]) 
    queueLock.release()
    
    # Wait for queue to empty
    while not workQueue.empty():
        pass
    # Notify threads it's time to exit
    exitFlag = 1
    # Wait for all threads to complete
    for t in threads:
        t.join()
    print "Exiting Main Thread"
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file',
                    required=True,
                    type=file,
                    dest="file",
                    metavar="<the absolute file path>",
                    help="The file for vagrant plugins sources" )
    parser.add_argument('-n', '--threads',
                    required=False,
                    type=int,
                    default=5,
                    dest="threads",
                    metavar="<number of threads>",
                    help="Number of run vagrant plugins add" )
    args = parser.parse_args()
    main(args.file,args.threads)