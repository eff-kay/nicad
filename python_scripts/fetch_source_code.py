from bs4 import BeautifulSoup
import requests
import os
from contract_addresses import contract_addresses

url = "https://etherscan.io/contractsVerified/"

def get_html(page_url):
	querystring = {"ps":"100"}
	response = requests.request("GET", page_url, params=querystring)
	return response.text
 

def get_contract_addresses():
	contract_addresses=[]
	for i in range(1,6):
		page_url = url+str(i)
		print("getting data for ", page_url)
		source = get_html(page_url)

		soup= BeautifulSoup(source)
		table = soup.find('table')
		curr_table_data = [(row("td")[0].text.strip(), row("td")[1].text.strip()) for row in BeautifulSoup(str(table))("tr")[1:]]
		contract_addresses+=curr_table_data
		print(contract_addresses, len(contract_addresses))
	# curr_table_data = [[cell.text.strip() for cell in row("td") if cell.text.strip()] for row in BeautifulSoup(str(table))("tr")]
	return contract_addresses


def get_code(contract_address):
	code_url = "https://etherscan.io/address/{}#code".format(contract_address)
	print("getting code from url {}".format(code_url))
	response = requests.request("GET", code_url)
	source = response.text
	soup = BeautifulSoup(source)
	code = soup.find("pre", {"id": "editor"}).text.strip()
	print("code fetched")
	return code


def save_code_to_file(code, contract_name):
	file_name = "smart_contracts/"+contract_name+".sol"
	print("creating file with filename {}".format(file_name))
	os.makedirs(os.path.dirname(file_name), exist_ok=True)
	with open(file_name, "w") as f:
		f.write(code)
		print("file {} created".format(contract_name))


def get_all_smart_contracts(contract_address):
	count=472
	for contract_address,contract_name in contract_addresses[472:]:
		code = get_code(contract_address)
		save_code_to_file(code, contract_name)
		print("contract number {} fetched".format(count))
		count+=1

if __name__ == '__main__':
	get_all_smart_contracts(contract_addresses)
	print("done")
