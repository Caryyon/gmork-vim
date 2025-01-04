# Jollama.nvim

Jollama is a Neovim plugin that allows you to highlight code, provide a prompt, and send both to a local Ollama API. The plugin then replaces the highlighted code with the response from the API.

## Installation

1. Install the plugin (use your preferred package manager):

```lua
use 'yourgithub/jollama.nvim'
```

2. Install dependencies:

```bash
luarocks install luasocket
luarocks install dkjson
```
