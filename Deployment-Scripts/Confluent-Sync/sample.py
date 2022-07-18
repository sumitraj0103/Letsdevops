
import json
import http.client

conn = http.client.HTTPSConnection("lkc-399xj-epwq2.southeastasia.azure.glb.confluent.cloud")

headers = { 'Authorization': "Basic T0dSRFVMVVFXNUdNNk1BQTpEQi90OU8vZS9ZMW9QM3pGNzZocWZ3b1hlbm1sekVFellyMlJlQWp2WHpYZVJhU2J2ZFFldHM4dmxWL3hkTE0x" }

conn.request("GET", "/kafka/v3/clusters/lkc-399xj/topics", headers=headers)

res = conn.getresponse()
data = res.read()

print(data.decode("utf-8"))

#test2
#f = open('C:\Projects\SCBCICD\deployment-scripts\confluent\confluent-topics.json')
  
# returns JSON object as 
# a dictionary
#data = json.load(f)
#for i in data['data']:
 #   print(i['topic_name'])
 #   print(i['replication_factor'])
 #   print(i['partitions_count'])
 #   print(i['topic_name'])
 #   print(i['replication_factor'])
 #   print(i['configs'])
 #   print(i['partition_reassignments'])
