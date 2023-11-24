slide.nvim
----------
slide up and down columns

<a href="https://asciinema.org/a/4AoLzZLGDoXxZEcCaldfbNEN1" target="_blank"><img src="https://asciinema.org/a/4AoLzZLGDoXxZEcCaldfbNEN1.svg" /></a>

### usage

```
local slide = require("slide")
vim.keymap.set({"n", "v"}, "<leader>k", slide.up)
vim.keymap.set({"n", "v"}, "<leader>j", slide.down)
```

slide.nvim is syntax aware and stops sliding once highlighting changes. this can be disabled with

```
local slide = require("slide")
vim.keymap.set({"n", "v"}, "<leader>k", function slide.up(false) end)
vim.keymap.set({"n", "v"}, "<leader>j", function slide.down(false) end)
```
