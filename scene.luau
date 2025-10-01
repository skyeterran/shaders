local render = require("render")

local uv_shader = render.shader{
    fragment = function(self)
        return vec4(self.uv, 0, 1)
    end
}

local scene = pipeline.scene()
scene.add_plane{
    shader = uv_shader
}

scene:render("test.png")
