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

function Show_Projects()
    local nvimDataPath = vim.fn.stdpath('data')
    local fileName = nvimDataPath .. "/dave-plug-projects"
    local file = io.open(fileName, "r")
    if file ~= nil then
        local projectsArray = {}
        io.input(file)
        for line in io.lines() do
            table.insert(projectsArray, line)
        end
        io.close(file)

        vim.ui.select(projectsArray,{ nrompt = "selezionare un progetto" }, function (str)
            if str ~= nil then
                vim.cmd("cd " .. str)
            end
        end)
    else
        print("errore all'apertura del file " .. fileName)
    end
end

function Add_Current_Working_Directory()
    local nvimDataPath = vim.fn.stdpath('data')
    local fileName = nvimDataPath .. "/dave-plug-projects"
    local file = io.open(fileName, "a")
    if file ~= nil then
        io.output(file)
        io.write(vim.fn.getcwd() .. "\n")
        io.close(file)
    else
        print("errore all'apertura del file " .. fileName)
    end
end

function Show_Files()
    local nvimDataPath = vim.fn.stdpath('data')
    local fileName = nvimDataPath .. "/dave-plug-files"
    local file = io.open(fileName, "r")
    if file ~= nil then
        local projectsArray = {}
        io.input(file)
        for line in io.lines() do
            table.insert(projectsArray, line)
        end
        io.close(file)

        vim.ui.select(projectsArray,{ nrompt = "selezionare un file" }, function (str)
            if str ~= nil then
                vim.cmd("e " .. str)
            end
        end)
    else
        print("errore all'apertura del file " .. fileName)
    end
end

function Add_Current_File()
    local nvimDataPath = vim.fn.stdpath('data')
    local fileName = nvimDataPath .. "/dave-plug-files"
    local file = io.open(fileName, "a")
    local bufnr = vim.api.nvim_win_get_buf(0)
    if file ~= nil then
        io.output(file)
        io.write(vim.api.nvim_buf_get_name(bufnr) .. "\n")
        io.close(file)
    else
        print("errore all'apertura del file " .. fileName)
    end
end
return {
    Elastic_function = Elastic_function,
    Elastic_interactive = Elastic_interactive,
    Add_Current_Working_Directory = Add_Current_Working_Directory,
    Show_Projects = Show_Projects,
    Add_Current_File = Add_Current_File,
    Show_Files = Show_Files,
}
