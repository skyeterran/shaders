local render = require("render")

return render.shader{
    fragment = function(self)
        local image = self.uniform("image")
        local uv = self.uniform("uv")
        return self.texture(image, uv)
    end
}
