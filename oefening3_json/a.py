import json
from jsonpath_ng.ext import parse
from pathlib import Path

def main():
    ROOT_DIR = Path.cwd()
    JSON_FILE = ROOT_DIR / 'oefening3_json' / 'schema.json'

    with open(JSON_FILE) as f:
        data = json.load(f)

    result = find_a_nodes(data)
    print(result)

def find_a_nodes(data):
    results = []

    def has_descendant(node, label, val):
        if isinstance(node, dict):
            for k, v in node.items():
                if k == label and isinstance(v, dict) and v.get('n') == val:
                    return True
                if has_descendant(v, label, val):
                    return True
        elif isinstance(node, list):
            for item in node:
                if has_descendant(item, label, val):
                    return True
        return False

    # Find all a-labeled nodes
    jsonpath_expr = parse('$..a')
    for match in jsonpath_expr.find(data):
        node = match.value
        if has_descendant(node, 'b', 8) and has_descendant(node, 'c', 9):
            results.append(node['n'])
    return results

if __name__ == '__main__':
    main()

# for $a in $doc//*:a
# where some $b in $a//*:b satisfies $b/n = 8
#  and some $c in $a//*:c satisfies $c/n = 9
# return $a/n