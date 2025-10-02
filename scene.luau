local utils = require("./utils")
local Shader = require("./shader")
local Uniform = Shader.Uniform
local Input = Shader.Input
local Texture = Shader.Texture

local result = {
    fragment = function()
        local image = Uniform.Sampler("image")
        local uv = Input.Vec2("uv")
        return Texture(image, uv)
    end
}

local fragment = result.fragment()
utils.emit(utils.to_prims(fragment))