import requests
from requests.auth import HTTPBasicAuth

basic = HTTPBasicAuth('admin', 'admin')
x = requests.get('http://192.168.0.24:8181/restconf/operational/opendaylight-inventory:nodes/', auth=basic)
print(x)