import requests, sys
import argparse
     
server = "http://rest.ensembl.org"
parser = argparse.ArgumentParser()
parser.add_argument("query_region", help='Region of the Chromosome; for example: X:1000000..1000100:1 (or) X:1000000..1000100:-1 (or) X:1000000..1000100')
args = parser.parse_args()
ext = "/map/human/GRCh38/"+args.query_region+"/GRCh37?"

r = requests.get(server+ext, headers={ "Content-Type" : "application/json"})
     
if not r.ok:
	r.raise_for_status()
	sys.exit()

print(repr(r.json()))

