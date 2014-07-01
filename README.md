Atom mark-mode
======

This extension for Atom mimics the set-mark command from emacs.
It is originally based from [atom-emacs-mode](https://github.com/fuqcool/atom-emacs-mode)
## Install

You can install it from `Atom -> Preferences -> Settings -> Packages`. To enable mark-mode automatically on Atom starts, put following code to your init script:

```
atom.packages.enablePackage('mark-mode').activateNow()
```

## Features

- Emacs set-mark command
- ~~set-mark command with multiple cursor~~

## Keymap

```
'.editor.emacs-marking':
  'right': 'core:select-right'
  'left':  'core:select-left'
  'up':    'core:select-up'
  'down':  'core:select-down'

'.platform-win32 .editor, .platform-linux .editor':
  'ctrl-e': 'mark-mode:set-mark'
  'ctrl-l': 'mark-mode:recenter'
```

## Contribution
Pull requests are very welcomed. The only requirement before sending a pull request is to pass the test cases and test your own code.
