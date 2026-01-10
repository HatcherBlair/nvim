Shoutout to the Primeagen for inspring me to switch to neovim, teej for providing kickstart(my first config), and MariaSolOs for having such a beautiful config I copied most of it.

## Navigating the Config
* Vim keybinds are set in lua/keybinds
* Vim settings are defined in lua/settings
* Plugin specific keybinds are defined in their configuration function located in lua/plugins/{plugin_name}.lua
* Language servers are configured in lsp/{language_server}.lua
* Any global auto commands are located in lua/autocommands.lua
* Lastly the colors directory will eventually be used to load a colorscheme instead of using a plugin.

## Installation
#### This configuration uses the beta version of nvim. This is currently verified for v0.12.0-dev-1810+g2b02dfa020
#### Noting is installed automatically, you have to do it yourself

### Other Required Software
In addition to the beta version of nvim you are going to need/want the following:
* git
* ripgrep
* fzf
* fd
* a monospaced nerd font
* probably some other stuff that I forgot about, let me know if there is anything else

### Installing Plugins
Plugins are installed using the Lazy package manager. To Install and update plugins run :Lazy
If you don't want plugins to be updated just run install and not update

* To add a plugin add the configuration to the lua/plugins directory

### Adding Language Support
Adding a language requires 3 changes to be made.
    1) Add a language server config in the LSP directory (you must intall the server and make it available on the path)
    2) Add it to the list of formatters in plugins/conform
    3) Install the parser via :TSInstall <parser>

## Supported Languages
#### LSP configurations are located in the LSP directory

### C/CPP
C and CPP use the clangd language server. This can be installed as a bundle with other LLVM tools.
clang-tidy and clang-format are used to linting and formatting.
On Windows, install these tools via the visual studio installer

### Csharp
The Roslyn language server DLL is available as a nuget package but I had dificulty getting a global install working YMMV.
Instead I downloaded the package straight from the Mason repository and made that available on my path.
You are also going to need csharpier which can be installed via `donet install csharpier -g`

* The csharp language server is slow to start, that's just how it is

### Lua
Lua uses the lua-language-server. It can be installed via scoop or brew.

## Plugin Specific Keybind/Instructions

### mini.files
This config does not use Netrw(yucky), instead it uses mini.files for navigation. The explorer can be opened with `<leader>e`, closed with `q` and help is opened with `?`

### LSP
Take a look at the lua/lsp.lua file for general lsp commands.

## Extras
If there is anything that you feel is missing in the readme, let me know or submit a pr and I will look into it.
