local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[                                                                     ]],
  [[                                                                     ]],
  [[            ██████╗ ███╗   ███╗ ██████╗ ██████╗ ██╗  ██╗            ]],
  [[           ██╔════╝ ████╗ ████║██╔═══██╗██╔══██╗██║ ██╔╝            ]],
  [[           ██║  ███╗██╔████╔██║██║   ██║██████╔╝█████╔╝             ]],
  [[           ██║   ██║██║╚██╔╝██║██║   ██║██╔══██╗██╔═██╗             ]],
  [[           ╚██████╔╝██║ ╚═╝ ██║╚██████╔╝██║  ██║██║  ██╗            ]],
  [[            ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝            ]],
  [[                                                                     ]],
  [[           ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓      ]],
  [[           ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒      ]],
  [[          ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░      ]],
  [[          ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██       ]],
  [[          ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒      ]],
  [[          ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░      ]],
  [[          ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░      ]],
  [[             ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░          ]],
  [[                   ░    ░  ░    ░ ░        ░   ░         ░          ]],
  [[                                          ░                         ]],
  [[                                                                     ]],
  [[                                                                     ]],
}

-- Safe git status function that checks if we're in a git repo
local function git_status_command()
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:match("true") then
      return ":Telescope git_status <CR>"
    end
  end
  return ":echo 'Not in a git repository. Use (p) to select a project.' <CR>"
end

dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("g", " " .. " Git status", git_status_command()),
  dashboard.button("m", " " .. " Markdown files", ":Telescope find_files find_command=fd,--type,f,--extension,md,--extension,mdx <CR>"),
  dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  dashboard.button("u", " " .. " Update plugins", ":Lazy sync<CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

local function footer()
  local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
  
  return "🐺 by Cary Wolff" .. nvim_version_info .. datetime
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)