import subprocess
import json

data = subprocess.run(['luau', 'scene.luau'], stdout=subprocess.PIPE).stdout.decode('utf-8')
data = json.loads(data)

with open("test.json", "w") as outfile:
    outfile.write(json.dumps(data, indent=4))

class Shader:
    def __init__(self, data):
        self.uniforms = {}
        self.inputs = {}
        self.prims = []
        for prim in data:
            kind = next(iter(prim))
            props = prim[kind]
            self.add_prim(kind, props)

    def add_prim(self, kind, props):
        attrs = {}
        for k, v in props.items():
            if "lit" in v:
                v = v["lit"]
            elif "ref" in v:
                v = f"p{v['ref']}"
            attrs[k] = v

        if kind == "uniform":
            name = attrs["name"]
            kind = attrs["kind"]
            self.uniforms[name] = kind
        elif kind == "input":
            name = attrs["name"]
            kind = attrs["kind"]
            self.inputs[name] = kind
        else:
            prim = {
                "kind": kind,
            }
            for k, v in attrs.items():
                prim[k] = v
            self.prims.append(prim)

    def debug(self):
        for name, kind in self.uniforms.items():
            print(f"uniform {kind} {name};")

        for name, kind in self.inputs.items():
            print(f"in {kind} {name};")

        for i, prim in enumerate(self.prims):
            print(f"p{i} = {prim};")

shader = Shader(data)
shader.debug()