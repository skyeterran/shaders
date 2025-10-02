local Shader = {}

Shader.Uniform = {
    Float = function(name) return {"float", name = name} end,
    Vec2 = function(name) return {"vec2", name = name} end,
    Sampler = function(name) return {"sampler", name = name} end,
}

Shader.Texture = function(sampler, uv)
    return {"texture", sampler = sampler, uv = uv}
end

return Shader