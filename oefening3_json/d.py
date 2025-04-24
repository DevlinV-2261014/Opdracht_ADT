import json
from pathlib import Path

def main():
    ROOT_DIR = Path.cwd()
    JSON_FILE = ROOT_DIR / 'oefening3_json' / 'schema.json'

    with open(JSON_FILE) as f:
        data = json.load(f)

    result = find_nodes_d(data)
    print(result)

def find_nodes_d(data):
    results = []

    def find_descendant_gt(node, limit):
        if isinstance(node, dict):
            if node.get('n', -1) > limit:
                return True
            for v in node.values():
                if find_descendant_gt(v, limit):
                    return True
        elif isinstance(node, list):
            for item in node:
                if find_descendant_gt(item, limit):
                    return True
        return False

    def traverse(node, ancestors=[]):
        if isinstance(node, dict):
            for label, val in node.items():
                if isinstance(val, dict):
                    if label == 'a' and find_descendant_gt(val, 3):
                        results.append(val['n'])
                    elif any(a.get('label') == 'b' and a.get('n') == 4 for a in ancestors):
                        if 'n' in val:
                            results.append(val['n'])
                    traverse(val, ancestors + [{'label': label, **val}])
                elif isinstance(val, list):
                    for item in val:
                        traverse(item, ancestors)

    traverse(data)
    return results

if __name__ == '__main__':
    main()

# for $node in $doc//*:*
# where ($node/name() = "a" and some $d in $node//*:* satisfies $d/n > 3)
#    or some $b in $node/ancestor::*:b satisfies $b/n = 4
# return $node/n