local emit = require("./serialize").emit
local Shader = require("./shader")
local Uniform = Shader.Uniform
local Texture = Shader.Texture

local result = {
    fragment = function()
        local image = Uniform.Sampler("image")
        local uv = Uniform.Vec2("uv")
        return Texture(image, uv)
    end
}

local prims = {}
local indices = {}
local index = 1
function record_prim(x)
    indices[x] = index
    if type(x) == "table" then
        local inputs = {}
        for k, v in x do
            if k ~= 1 then
                inputs[k] = record_prim(v)
            end
        end
        table.insert(prims, {[x[1]] = inputs})
        index += 1
        return {reference = index - 2}
    else
        return {literal = x}
    end
end

local fragment = result.fragment()
record_prim(fragment)
emit(prims)