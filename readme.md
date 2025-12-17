Shoutout to the Primeagen for inspring me to switch to neovim, teej for providing kickstart(my first config), and MariaSolOs for having such a beautiful config I copied most of it.

### Installation

* Noting is installed automatically, you have to do it yourself
* Plugins are version locked, run :Lazy Install to get all your plugins installed
* Adding a language requires 3 changes to be made.
    * Add a language server config in the LSP directory
    * Add it to the list of parsers in plugins/conform
    * Add it to the ensure installed list in plugins/treesitter
* All highlight groups are configured in colors/colorscheme
* Vim keybinds are set in keybinds
* Vim settings are defined in settings
* Plugin specific keybinds are defined in their configuration function
