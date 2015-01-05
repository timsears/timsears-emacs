## My emacs configuration.

Installation
0) Delete ~/.emacs if it exists. Emacs will automatically use ~/.emacs.d/init.el instead.
1) Clone this repo into .emacs.d.
2) Clone chrisdone-emacs into ~/.emacs.d/chrisdone-emacs.

    git clone git@github.com:chrisdone/chrisdone-emacs.git.

Or

    git clone git@github.com:timesears/chrisdone-emacs.git

The latter is a fork with default branch 'timtweaks'.
3) Follow the directions in the README.

Note that chrisdone-emacs is neither a subtree or a submodule. It
should be updated separately and is listed in .gitignore. Maybe there
is a better way to manage this.

### Differences in timtweaks.

* Some magit and haskell-mode key bindings.
* I installed magit via nix after encountering some error in the version
chrisdone tracks.

### Future.
* Was hoping to track many more dependencies via nix but that did not
  work well. haskell-mode in nix seems wa
