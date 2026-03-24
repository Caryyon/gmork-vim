-- vim-tidal configuration for TidalCycles live coding

-- Set local leader for Tidal commands
vim.g.maplocalleader = ","

-- Key bindings for TidalCycles
local opts = { noremap = true, silent = true }

-- Evaluate current paragraph (Ctrl-e)
vim.keymap.set("n", "<C-e>", "<Plug>TidalParagraphSend", opts)

-- Send current inner paragraph
vim.keymap.set("n", "<localleader>ss", "<Plug>TidalParagraphSend", { desc = "Send paragraph to Tidal" })

-- Send current line
vim.keymap.set("n", "<localleader>s", "<Plug>TidalLineSend", { desc = "Send line to Tidal" })

-- Send visual selection
vim.keymap.set("v", "<localleader>s", "<Plug>TidalRegionSend", { desc = "Send selection to Tidal" })

-- Hush (silence all)
vim.keymap.set("n", "<localleader>h", "<Plug>TidalHush", { desc = "Hush (silence all)" })

-- Solo specific streams
vim.keymap.set("n", "<localleader>1", "vip<Plug>TidalRegionSend", { desc = "Solo d1" })
vim.keymap.set("n", "<localleader>2", "vip<Plug>TidalRegionSend", { desc = "Solo d2" })
vim.keymap.set("n", "<localleader>3", "vip<Plug>TidalRegionSend", { desc = "Solo d3" })

-- Configure Tidal to use Neovim's terminal
vim.g.tidal_target = "terminal"

-- Optional: Set ghci path if using stack or custom installation
-- vim.g.tidal_ghci = "stack exec -- ghci"

-- Auto-commands for .tidal files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tidal",
  callback = function()
    vim.opt_local.commentstring = "-- %s"
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Create BootTidal.hs if it doesn't exist
local function ensure_boot_tidal()
  local home = vim.fn.expand("~")
  local boot_file = home .. "/BootTidal.hs"

  if vim.fn.filereadable(boot_file) == 0 then
    local boot_content = [[
:set -XOverloadedStrings
:set prompt ""

import Sound.Tidal.Context

-- total latency = oLatency + cFrameTimespan
tidal <- startTidal (superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}) (defaultConfig {cVerbose = True, cFrameTimespan = 1/20})

:{
let only = (hush >>)
    p = streamReplace tidal
    hush = streamHush tidal
    panic = do hush
               once $ sound "superpanic"
    list = streamList tidal
    mute = streamMute tidal
    unmute = streamUnmute tidal
    unmuteAll = streamUnmuteAll tidal
    unsoloAll = streamUnsoloAll tidal
    solo = streamSolo tidal
    unsolo = streamUnsolo tidal
    once = streamOnce tidal
    first = streamFirst tidal
    asap = once
    nudgeAll = streamNudgeAll tidal
    all = streamAll tidal
    resetCycles = streamResetCycles tidal
    setcps = asap . cps
    getcps = streamGetcps tidal
    getnow = streamGetnow tidal
    xfade i = transition tidal True (Sound.Tidal.Transition.xfadeIn 4) i
    xfadeIn i t = transition tidal True (Sound.Tidal.Transition.xfadeIn t) i
    histpan i t = transition tidal True (Sound.Tidal.Transition.histpan t) i
    wait i t = transition tidal True (Sound.Tidal.Transition.wait t) i
    waitT i f t = transition tidal True (Sound.Tidal.Transition.waitT f t) i
    jump i = transition tidal True (Sound.Tidal.Transition.jump) i
    jumpIn i t = transition tidal True (Sound.Tidal.Transition.jumpIn t) i
    jumpIn' i t = transition tidal True (Sound.Tidal.Transition.jumpIn' t) i
    jumpMod i t = transition tidal True (Sound.Tidal.Transition.jumpMod t) i
    jumpMod' i t p = transition tidal True (Sound.Tidal.Transition.jumpMod' t p) i
    mortal i lifespan release = transition tidal True (Sound.Tidal.Transition.mortal lifespan release) i
    interpolate i = transition tidal True (Sound.Tidal.Transition.interpolate) i
    interpolateIn i t = transition tidal True (Sound.Tidal.Transition.interpolateIn t) i
    clutch i = transition tidal True (Sound.Tidal.Transition.clutch) i
    clutchIn i t = transition tidal True (Sound.Tidal.Transition.clutchIn t) i
    anticipate i = transition tidal True (Sound.Tidal.Transition.anticipate) i
    anticipateIn i t = transition tidal True (Sound.Tidal.Transition.anticipateIn t) i
    forId i t = transition tidal False (Sound.Tidal.Transition.mortalOverlay t) i
    d1 = p 1 . (|< orbit 0)
    d2 = p 2 . (|< orbit 1)
    d3 = p 3 . (|< orbit 2)
    d4 = p 4 . (|< orbit 3)
    d5 = p 5 . (|< orbit 4)
    d6 = p 6 . (|< orbit 5)
    d7 = p 7 . (|< orbit 6)
    d8 = p 8 . (|< orbit 7)
    d9 = p 9 . (|< orbit 8)
    d10 = p 10 . (|< orbit 9)
    d11 = p 11 . (|< orbit 10)
    d12 = p 12 . (|< orbit 11)
    d13 = p 13
    d14 = p 14
    d15 = p 15
    d16 = p 16
:}

:set prompt "tidal> "
:set prompt-cont ""

putStrLn ""
putStrLn "TidalCycles loaded!"
]]
    vim.fn.writefile(vim.split(boot_content, "\n"), boot_file)
    print("Created BootTidal.hs in " .. boot_file)
  end
end

-- Ensure boot file exists
ensure_boot_tidal()
