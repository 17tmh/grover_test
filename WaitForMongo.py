#!/usr/bin/env python3

import pymongo
import time

CONNECTION_STRING = "mongodb://user:user@localhost:27018/?authSource=admin"
client = pymongo.MongoClient(CONNECTION_STRING, serverSelectionTimeoutMS=3000)

while(True):
    try:
        print("Trying to connect to MongoDB:")
        print(CONNECTION_STRING)
        client.server_info()
        print("Success: Connection established!")
        break
    except:
        print("Error: Could not reach server!")

time.sleep(0.5)