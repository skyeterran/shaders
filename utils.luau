local module = {}

module.serialize = function(x)
    local result = ""
    if type(x) == "table" then
        local is_array = true
        local next_index = 1
        for k, v in x do
            if type(k) ~= "number" then
                is_array = false; break
            elseif k ~= next_index then
                is_array = false; break
            else
                next_index += 1
            end
        end
        result = if is_array then "[" else "{"
        local is_first = true
        for k, v in x do
            local separator = if is_first then "" else ", "
            if is_array then
                result = result .. `{separator}{module.serialize(v)}` 
            else
                result = result .. `{separator}\"{k}\": {module.serialize(v)}` 
            end
            is_first = false
        end
        result = result .. if is_array then "]" else "}"
    elseif type(x) == "string" then
        result = `\"{x}\"`
    else
        result = `{x}`
    end
    return result
end

function module.emit(x)
    print(module.serialize(x))
end

function module.to_prims(x)
    local prims = {}
    local indices = {}
    local index = 1
    local function record_prim(x)
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
            return {ref = index - 2}
        else
            return {lit = x}
        end
    end
    record_prim(x)
    return prims
end

return module