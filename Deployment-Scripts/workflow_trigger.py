
import os
import requests
import sys

TOKEN= str(sys.argv[1])
OWNER= str(sys.argv[2])
REPO= str(sys.argv[3])
Workflow_Name= str(sys.argv[4])
pl_Baseline_Number= str(sys.argv[5])
pl_Baseline_Revision = str(sys.argv[6])


print( "the toke value is")
def trigger_workflow(Workflow_Name,pl_Baseline_Number,pl_Baseline_Revision):

      headers = {
        "Accept": "application/vnd.github.v3+json",
        "Authorization": f"token {TOKEN}",
      }

      data = {
        "event_type": Workflow_Name,
        "client_payload": {
          'baselinetag': pl_Baseline_Number,
          'revision_number': pl_Baseline_Revision
        }
      }

<<<<<<< HEAD
      responseValue=requests.post(f"https://api.github.com/repos/{OWNER}/{REPO}/dispatches",json=data,headers=headers)
      print(responseValue.content)

=======
      responsevalue=requests.post(f"https://api.github.com/repos/{OWNER}/{REPO}/dispatches",json=data,headers=headers)
      print("The respoinse message is ",responsevalue.content)
>>>>>>> 751944b1a6e004d054332975b0e13f2a246194a1

trigger_workflow(Workflow_Name,pl_Baseline_Number,pl_Baseline_Revision)
