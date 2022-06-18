# vide

An effort to utilize vim and tmux to create a comfy environment to write software in.

## Dependencies

* `nnn`
* `tmux`
* `nvim`

## Setup

```
git clone https://github.com/distek/config.nvim.git ~/.config/nvim
git clone https://github.com/distek/config.tmux.git ~/.config/tmux
git clone https://github.com/distek/projects.git ~/git-clones/projects
git clone https://github.com/distek/vide.git ~/git-clones/vide

mkdir -p ~/.local/bin

ln -s ~/git-clones/vide/vide ~/.local/bin/vide
ln -s ~/git-clones/projects/projects ~/.local/bin/projects

ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
```

## Usage
I had lots of issues if tmux wasn't already started, so `cd` into whatever directory, start tmux, and then start vide.

When in whichever directory, you can save the current project directory with `projects save` and, using my tmux config, do `A-Space` and `O` to load the project later.

I should do a writeup on my tmux config at some point.


