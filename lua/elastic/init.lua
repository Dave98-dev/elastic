local function selected_lines()
    local vstart = vim.fn.getpos("'<")

    local vend = vim.fn.getpos("'>")

    local line_start = vstart[2]
    local line_end = vend[2]

    -- or use api.nvim_buf_get_lines
    local lines = vim.fn.getline(line_start,line_end)
    return lines, line_start, line_end
end

function Elastic_function(symbol)
    local bufnr = vim.api.nvim_win_get_buf(0)
    local lines, line_start, line_end = selected_lines()
    local max_equals = 0
    for i, line in ipairs(lines) do
        local indexOfEq = string.find(line, symbol)
        if indexOfEq ~= nil and indexOfEq > max_equals then
            max_equals = indexOfEq
        end
    end

    local newLines = {}

    for i, line in ipairs(lines) do
        local indexOfEq = string.find(line, symbol)
        local diff = 0
        if indexOfEq ~= nil then
            diff = max_equals - indexOfEq
        end
        local newLine = string.gsub(line, symbol, string.rep(" ", diff) .. symbol, 1)
        table.insert(newLines, newLine)
    end

    vim.api.nvim_buf_set_lines(bufnr, line_start-1, line_end, false, newLines)
end


function Elastic_interactive()
    local symbol = vim.fn.input("specificare il simbolo: ")
    Elastic_function(symbol)
end

return {
    Elastic_function = Elastic_function,
    Elastic_interactive = Elastic_interactive
}
