import json
from jsonpath_ng.ext import parse
from pathlib import Path

def main():
    ROOT_DIR = Path.cwd()
    JSON_FILE = ROOT_DIR / 'oefening3_json' / 'schema.json'

    with open(JSON_FILE) as f:
        data = json.load(f)

    result = find_b_nodes(data)
    print(result)

def find_b_nodes(data):
    results = []
    jsonpath_expr = parse('$..b')

    for match in jsonpath_expr.find(data):
        b_node = match.value
        children = b_node.get('children', [])
        c_idx = d_idx = -1
        for idx, child in enumerate(children):
            if 'c' in child and child['c'].get('n') == 3:
                c_idx = idx
            if 'd' in child and child['d'].get('n') == 4:
                d_idx = idx
        if c_idx != -1 and d_idx != -1 and c_idx < d_idx:
            results.append(b_node['n'])
    return results

if __name__ == '__main__':
    main()

# for $b in $doc//*:b
# let $children := $b/*
# where some $i in (1 to count($children))
#       satisfies $children[$i]/name() = "c" and $children[$i]/n = 3
#     and some $j in ($i+1 to count($children))
#       satisfies $children[$j]/name() = "d" and $children[$j]/n = 4
# return $b/n