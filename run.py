import subprocess
import json

result = subprocess.run(['luau', 'test.luau'], stdout=subprocess.PIPE).stdout.decode('utf-8')
result = json.loads(result)

with open("test.json", "w") as outfile:
    outfile.write(json.dumps(result, indent=4))