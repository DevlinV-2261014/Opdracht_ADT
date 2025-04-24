import json
from jsonpath_ng.ext import parse
from pathlib import Path

def main():
    ROOT_DIR = Path.cwd()
    JSON_FILE = ROOT_DIR / 'oefening3_json' / 'schema.json'

    with open(JSON_FILE) as f:
        data = json.load(f)

    result = find_nodes_c(data)
    print(result)

def find_nodes_c(data):
    results = []

    def find_descendant(node, label, n_val):
        if isinstance(node, dict):
            for k, v in node.items():
                if k == label and isinstance(v, dict) and v.get('n') == n_val:
                    return True
                if find_descendant(v, label, n_val):
                    return True
        elif isinstance(node, list):
            for item in node:
                if find_descendant(item, label, n_val):
                    return True
        return False

    def search_siblings(children):
        for i, wrapper in enumerate(children):
            label = next(iter(wrapper))
            node = wrapper[label]
            has_b_desc = find_descendant(node, 'b', 0)
            has_sibling_n1 = any(
                next(iter(sib.values())).get('n') == 1 for sib in children[i+1:]
            )
            if has_b_desc or has_sibling_n1:
                results.append(node['n'])

    jsonpath_expr = parse('$.r.children')
    for match in jsonpath_expr.find(data):
        search_siblings(match.value)

    return results

if __name__ == '__main__':
    main()

# for $node at $i in $doc//*:*
# let $siblings := $node/../* 
# where some $b in $node//*:b satisfies $b/n = 0
#    or ($i < count($siblings) and $siblings[$i + 1]/n = 1)
# return $node/n