import requests
import json
import sys
import os

tenant_id= os.environ.get("TENANT_ID")
client_id= os.environ.get("CLIENT_ID")
client_secret= os.environ.get("CLIENT_SECRET")
subscription_id= os.environ.get("SUBSCRIPTION_ID")
resourceGroup= os.environ.get("TargetAPIM_RG")
apim_service=os.environ.get("TargetAPIM_NAME")
Template_path=os.environ.get("ARMtemplate_Path")
apis_list=os.environ.get("apis_list")
apis_delete_list=os.environ.get("apis_delete_list")
result_api=apis_list.split(",")
print("The result API is : ", result_api)
# Change to True for Deploy else set False
deploy_apis=True
deploy_namedValues=False
deploy_backends=False
deploy_operations=True
deploy_policies=True
deploy_ops_policies=True

TOKEN_REQ_BODY = {
    'grant_type': 'client_credentials',
    'client_id':  client_id,
    'client_secret':  client_secret}

TOKEN_BASE_URL = 'https://login.microsoftonline.com/' +  tenant_id + '/oauth2/token'
TOKEN_REQ_HEADERS = {'Content-Type': 'application/x-www-form-urlencoded'}



def api_management_token():
        TOKEN_REQ_BODY['resource'] = 'https://management.core.windows.net/'
        response = requests.get(TOKEN_BASE_URL, headers=TOKEN_REQ_HEADERS, data=TOKEN_REQ_BODY)
        if response.status_code == 200:
            print(response.status_code)
        else:
            raise Exception(response.text)
        return response.json()['access_token']

DF_MANAGEMENT_TOKEN = api_management_token()

DF_WorksID_REQ_HEADERS = {
    'Authorization': 'Bearer ' + DF_MANAGEMENT_TOKEN,
    'Content-Type': 'application/json'}
def create_apis(properties_value,apiName):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+apiName+"?api-version=2021-08-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    
    pro_json=json.dumps(properties_value)
    bodyvalue='{"properties":'+pro_json+"}"
    json_value=json.loads(bodyvalue)
    print("creating apis for",apiName)
    print(" apis body is",json_value)
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value
    )
    #Validate response code
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()
def delete_apis(apiName):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+apiName+"?api-version=2020-12-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    
    response = requests.delete(
        target_api_url,
        headers=headers
    )
    #Validate response code
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()

def create_operations(collproperties,opapiname,operationname):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    print("creating operation for",operationname)
    print(" Operation body is",collproperties)
    pro_json=json.dumps(collproperties)
    pro_json.replace("None","'None'")
    json_value_ops=json.loads(pro_json)
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value_ops
    )
    #Validate response code
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()
 
def delete_operations(collproperties,opapiname,operationname):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2020-12-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.delete(
        target_api_url,
        headers=headers
    )
    #Validate response code
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()
        
def create_policies(policyproperties,opapiname):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+opapiname+"/policies/policy?api-version=2020-12-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    print("creating operation for Policy with Body",policyproperties)

    pro_json=json.dumps(policyproperties)
    #pro_json.replace("None","'None'")
    json_value_ops=json.loads(pro_json)
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value_ops
    )
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()

def create_backend(backendproperties,backendname):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/backends/"+backendname+"?api-version=2020-12-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    print("Creating backend Name ",backendname)
    print("Sending Body Detail ",backendproperties)
    pro_json=json.dumps(backendproperties)
    #pro_json.replace("None","'None'")
    json_value_ops=json.loads(pro_json)
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value_ops
    )
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()

def create_namedValue(namedValueproperties,namedValue):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/namedValues/"+namedValue+"?api-version=2020-12-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    print("Creating namedValue ",namedValue)
    print("Creating Body of namedValue ",namedValueproperties)
    pro_json=json.dumps(namedValueproperties)
    #pro_json.replace("None","'None'")
    json_value_ops=json.loads(pro_json)
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value_ops
    )
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()
        
def create_ops_policies(policyproperties,opapiname,opname):
    target_api_url="https://management.azure.com/subscriptions/"+subscription_id+"/resourcegroups/"+resourceGroup+"/providers/Microsoft.ApiManagement/service/"+apim_service+"/apis/"+opapiname+"/operations/"+opname+"/policies/policy?api-version=2021-08-01"
    headers = {'Authorization': 'Bearer {}'.format(DF_MANAGEMENT_TOKEN)}
    print("creating operation for Policy with Body",policyproperties)

    pro_json=json.dumps(policyproperties)
    #pro_json.replace("None","'None'")
    json_value_ops=json.loads(pro_json)
    #target_api_url="https://management.azure.com/subscriptions/"+target_subscription_id+"/resourcegroups/"+target_resourceGroup+"/providers/Microsoft.ApiManagement/service/"+Target_servie_Name+"/apis/"+opapiname+"/operations/"+operationname+"?api-version=2021-08-01"
    response = requests.put(
        target_api_url,
        headers=headers,
        json=json_value_ops
    )
    print("the response code is",response.status_code)
    if response.status_code == 400:    
        raise Exception("API Failed, Result: {}".format(response.json()))    
        response.raise_for_status()
        
# Get and Create API
print("the dir Path",Template_path)
file_path = os.path.join(Template_path,'template.json')
print("the file Path",file_path)
with open(file_path, 'r',encoding='utf-8') as f:
    data = json.load(f)

#print("NOt able to Load the File")
#Create APIs
if deploy_apis == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    if item['type'] == 'Microsoft.ApiManagement/service/apis':
                        #print("the Database item is ",item['properties'])
                        apis_json=item['properties']
                        apis_string=item['name'].split(",")
                        apis_laststring=apis_string[1]
                        apis_value=apis_laststring.split("/")
                        api_Name=apis_value[1].replace("')]","")
                        api_name_value=api_Name.replace("')]","")
                
                        print("Checking and Creating apis..",api_name_value)
                        if api_name_value in result_api or 'all' in result_api:
                            print("The Selcted API is ready to create",api_Name)
                            create_apis(apis_json,api_name_value)
                        else:
                            print("We are not creating API since is it not selected to Create",api_Name)
                       
#Create namedValue
if deploy_namedValues == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    #print("The Operations item is", item)
                    if item['type'] == 'Microsoft.ApiManagement/service/namedValues':
                        namedValuejson=item['properties']
                        namedValueString=item['name'].split(",")
                        LastString=namedValueString[1]
                        namedValue=LastString.split("/")
                        namedValue_name=namedValue[1].replace("')]","")
                        updated_json_value='{'+'"properties"'+":"+json.dumps(namedValuejson)+'}'
                        json_object = json.loads(updated_json_value)
                        print("the Named Value",namedValue_name)
                        print("Backend Json Object is",json_object)
                        create_namedValue(json_object,namedValue_name)
                       

#Create Backend
if deploy_backends == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    #print("The Operations item is", item)
                    if item['type'] == 'Microsoft.ApiManagement/service/backends':
                        backendjson=item['properties']
                        backendString=item['name'].split(",")
                        LastString=backendString[1]
                        backend=LastString.split("/")
                        backend_name=backend[1].replace("')]","")
                        updated_json_value='{'+'"properties"'+":"+json.dumps(backendjson)+'}'
                        json_object = json.loads(updated_json_value)
                        create_backend(json_object,backend_name)
                       


#Create Operations
if deploy_operations == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    #print("The Operations item is", item)
                    if item['type'] == 'Microsoft.ApiManagement/service/apis/operations':
                        #print("the Collection item is ",item['properties'])
                        #print("Operation Name is",item['name'])
                        operationjson=item['properties']
                        #print("Operation Json Value",operationjson)
                        operationString=item['name'].split(",")
                        #print("Database name after split",databasenameString[1])
                        LastString=operationString[1]
                        apis=LastString.split("/")
                        api_name=apis[1]
                        api_operation_name=apis[2].replace("')]","")
                        updated_json_value='{'+'"properties"'+":"+json.dumps(operationjson)+'}'
                        json_object = json.loads(updated_json_value)
                        print("API Name and Operation Name",api_name,api_operation_name)
                        #print("Json Object is",json_object)
                        if api_name in result_api or 'all' in result_api:
                            create_operations(json_object,api_name,api_operation_name)

#Create api policies
if deploy_policies == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    #print("The Operations item is", item)
                    if item['type'] == 'Microsoft.ApiManagement/service/apis/policies':
                        operationjson=item['properties']
                        #print("Policies Json",operationjson)
                        operationString=item['name'].split(",")
                        LastString=operationString[1]
                        apis=LastString.split("/")
                        api_name=apis[1]
                        updated_json_value='{'+'"properties"'+":"+json.dumps(operationjson)+'}'
                        #print("Operation Name",updated_json_value)
                        updated_apijson_load=json.loads(updated_json_value)
                        #print("Operation Name",updated_apijson_load)
                        json_object = json.loads(updated_json_value)
                        print("API Name",api_name)
                        #print("Policy Json Object is",json_object)
                        if api_name in result_api or 'all' in result_api:
                            print("Creating API Policies with :")
                            create_policies(json_object,api_name)
                        else:
                            print("We are not creating policies for :",api_name)
#Create operation policies
if deploy_ops_policies == True:
    for i in data:
            if i == "resources":
                for item in data[i]:
                    #print("The Operations item is", item)
                    if item['type'] == 'Microsoft.ApiManagement/service/apis/operations/policies':
                        #print("the Collection item is ",item['properties'])
                        #print("Operation Name is",item['name'])
                        operationjson=item['properties']
                        #print("Policies Json",operationjson)
                        operationString=item['name'].split(",")
                        #print("Database name after split",databasenameString[1])
                        LastString=operationString[1]
                        apis=LastString.split("/")
                        api_name=apis[1]
                        operation_name=apis[2]
                        updated_json_value='{'+'"properties"'+":"+json.dumps(operationjson)+'}'
                        #print("Operation Name",updated_json_value)
                        updated_apijson_load=json.loads(updated_json_value)
                        #print("Operation Name",updated_apijson_load)
                        json_object = json.loads(updated_json_value)
                        print("API Name",api_name)
                        print("Operation Name",operation_name)
                        print("Json PayLoad",json_object)
                        #print("Policy Json Object is",json_object)
                        if api_name in result_api or 'all' in result_api:
                            print("Creating Operation Policies with :")
                            create_ops_policies(json_object,api_name,operation_name)
                        else:
                            print("We are not creating Operation policies for :",api_name)
                        
