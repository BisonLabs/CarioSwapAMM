%{
    import requests
    import json
    import configparser

    def get_contract_data(tick):
    response = requests.post(f"{bison_network_service_endpoint}/contract", json={"tick": tick})
    data = response.json()
    return data

    def check_balance(endpoint, address, amount_required):
    response = requests.post(f"{endpoint}/balance", json={"address": address})
    balance = response.json().get('balance', 0)
    return balance >= float(amount_required) # 将 amount_required 转换为浮点数

    config = configparser.ConfigParser()
    config.read('config.ini')
    tick_values = [config['TICKS']['value1'], config['TICKS']['value2']]
    bison_network_service_endpoint = config['API']['BisonNetworkService']
    contract_address = config['ContractAddress']['contractAddress']
    priv_key = config['ContractAddress']['privKey']
    tick1_balance_endpoint = tick1_endpoint + "/balance"
    tick2_balance_endpoint = tick2_endpoint + "/balance"
    tick1_balance_response = requests.post(tick1_balance_endpoint, json={"address": contract_address})
    tick2_balance_response = requests.post(tick2_balance_endpoint, json={"address": contract_address})
    tick1_balance = float(tick1_balance_response.json().get('balance', 0))
    tick2_balance = float(tick2_balance_response.json().get('balance', 0))
    
%}