import json
from jsonpath_ng.ext import parse

def main():
    with open('..\\oefening1_json\\shop.json') as f: # You have to run this from the folder where the script is located
        data = json.load(f)

    jsonpath_expr = parse('$.baskets[?(@.items[*].quantity >= 4)]')
    results = [match.value for match in jsonpath_expr.find(data)]
    print(results)

if __name__ == '__main__':
    main()