function serialize(x)
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
                result = result .. `{separator}{serialize(v)}` 
            else
                result = result .. `{separator}\"{k}\": {serialize(v)}` 
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

print(serialize{
    {42, this = "is", a = "dict"},
    {1, 3, 5, 7, {name = "Dog", height = 20}},
    420,
    {ship_id = "crestfall_a9", rating = 0.123},
    "Hello, world!"
})