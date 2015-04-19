Text Object for Conflicts on Merge
==================================

## Installation

Please use your favorite plugin manager and follow the instruction of it.  Below is an example for [neobundle.vim](https://github.com/Shougo/neobundle.vim).

```vim
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'rhysd/vim-textobj-conflict'
```

## Dependency

This plugin depends on [vim-textobj-user](https://github.com/kana/vim-textobj-user).  Please install it in advance.

## Usage

`i=` and `a=` operator-pending mappings are available.  `i=` selects the inner lines of either ours or theirs of the conflict.  `a=` selects the whole lines of either ours or theirs of the conflict (including markers).

If you use above mappings outside a conflict, it jumps the cursor to next conflict.

Try `va=`, `vi=`, `da=` and so on when the buffer includes some conflicts.

![screenshot](https://raw.githubusercontent.com/rhysd/screenshots/master/vim-textobj-conflict/textobj-conflict.gif)

## Customization

If you want to map operator-pending mappings, please use `g:textobj_conflict_no_default_key_mappings` as below:

```vim
let g:textobj_conflict_no_default_key_mappings = 1

omap ix <Plug>(textobj-conflict-i)
omap ax <Plug>(textobj-conflict-a)
```

## TODO(s)

- Tests
- Documentation

## License

This software is distributed under [the MIT License](http://opensource.org/licenses/MIT).
