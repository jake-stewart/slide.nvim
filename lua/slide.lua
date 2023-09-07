local function virtIdx(str, targetIdx)
    if #str == 0 then
        return " "
    end
    local idx = 0
    for i = 1, #str do
        local c = str:sub(i,i)
        if c == "\t" then
            idx = (idx / vim.o.ts + 1) * vim.o.ts
        else
            idx = idx + vim.fn.strdisplaywidth(c)
        end

        if idx >= targetIdx then
            return c
        end
    end
end

local function slide(direction, smart_syntax)
    local syntax = smart_syntax and vim.fn.exists("*synstack") == 1

    local col = vim.fn.col('.')
    local line = vim.fn.line('.')
    local max_line = vim.fn.line('$')
    local stack

    local space_before
    local space_after
    local char_before
    local char_after

    if syntax then
        stack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
    end

    if col > 1 then
        char_before = virtIdx(vim.fn.getline(line), col - 1)
        space_before = (char_before == ' '
                    or char_before == ''
                    or char_before == "\t")
    end

    char_after = virtIdx(vim.fn.getline(line), col)
    space_after = (char_after == ' '
                or char_after == ''
                or char_after == "\t")

    while true do
        line = line + direction

        if line > max_line or line == 0 then
            break
        end

        if vim.fn.strdisplaywidth(vim.fn.getline(line)) < col - 1 then
            break
        end

        if syntax then
            local newstack = vim.fn.synstack(line, col)
            if #newstack == 0 then
                if #stack > 0 then
                    break
                end
            elseif #stack == 0 then
                break
            elseif stack[-1] ~= newstack[-1] then
                break
            end
        end

        char_after = virtIdx(vim.fn.getline(line), col)
        local new_space_after = (char_after == ' '
                    or char_after == ''
                    or char_after == "\t")
        if new_space_after ~= space_after then
            break
        end

        if col > 1 then
            char_before = virtIdx(vim.fn.getline(line), col - 1)
            local new_space_before = (char_before == ' '
                        or char_before == ''
                        or char_before == "\t")
            if new_space_before ~= space_before then
                break
            end
        end
    end

    local jump
    local jump_char

    if direction == 1 then
        jump = line - vim.fn.line('.') - 1
        jump_char = 'j'
    else
        jump = vim.fn.line('.') - line - 1
        jump_char = 'k'
    end

    if jump > 1 then
        vim.fn.feedkeys(jump .. jump_char, "n")
    elseif jump == 1 then
        vim.fn.feedkeys(jump_char, "n")
    end
end

return {
    up = function()
        return slide(-1, false)
    end,
    down = function()
        return slide(1, false)
    end,
    upHL = function()
        return slide(-1, true)
    end,
    downHL = function()
        return slide(1, true)
    end,
}
