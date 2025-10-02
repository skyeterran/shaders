local Shader = {}

Shader.Uniform = {
    Float = function(name) return {
        "uniform",
        kind = "float",
        name = name
    } end,
    Vec2 = function(name) return {
        "uniform",
        kind = "vec2",
        name = name
    } end,
    Sampler = function(name) return {
        "uniform",
        kind = "sampler",
        name = name
    } end,
}

Shader.Input = {
    Vec2 = function(name) return {
        "input",
        kind = "vec2",
        name = name
    } end,
}

Shader.Texture = function(sampler, uv)
    return {"texture", sampler = sampler, uv = uv}
end

return Shader