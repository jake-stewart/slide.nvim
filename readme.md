slide.nvim
----------
slide up and down columns

### usage

```
local slide = require("slide")
vim.keymap.set({"n", "v"}, "<leader>k", slide.up)
vim.keymap.set({"n", "v"}, "<leader>j", slide.down)
```

slide.nvim can also be syntax aware and stop sliding once highlighting changes

```
local slide = require("slide")
vim.keymap.set({"n", "v"}, "<leader>k", slide.upHL)
vim.keymap.set({"n", "v"}, "<leader>j", slide.downHL)
```
